/*
 * Copyright 2015 Jean-Bernard van Zuylen
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.primeoservices.cfpass;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.security.KeyStore;
import java.security.PrivateKey;
import java.security.Security;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;

import org.bouncycastle.asn1.ASN1EncodableVector;
import org.bouncycastle.asn1.DERSet;
import org.bouncycastle.asn1.DERUTCTime;
import org.bouncycastle.asn1.cms.AttributeTable;
import org.bouncycastle.asn1.cms.CMSAttributes;
import org.bouncycastle.asn1.pkcs.Attribute;
import org.bouncycastle.cert.jcajce.JcaCertStore;
import org.bouncycastle.cms.CMSProcessableFile;
import org.bouncycastle.cms.CMSSignedData;
import org.bouncycastle.cms.CMSSignedDataGenerator;
import org.bouncycastle.cms.DefaultSignedAttributeTableGenerator;
import org.bouncycastle.cms.jcajce.JcaSignerInfoGeneratorBuilder;
import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.bouncycastle.operator.ContentSigner;
import org.bouncycastle.operator.jcajce.JcaContentSignerBuilder;
import org.bouncycastle.operator.jcajce.JcaDigestCalculatorProviderBuilder;
import org.bouncycastle.util.Store;

public class PassUtils
{
  /**
   * This utilities class should never be initialized
   */
  private PassUtils()
  {
  }
  
  public static void createSignature(final String directoryPath, final String keyStoreFilePath, final String keyStorePassword) throws Exception
  {
    // Add BC provider
    if (Security.getProvider(BouncyCastleProvider.PROVIDER_NAME) == null)
    {
      Security.addProvider(new BouncyCastleProvider());
    }
    
    // Check directory
    final File directory = new File(directoryPath);
    if (directory.exists() && !directory.isDirectory())
    {
      throw new IllegalArgumentException(directoryPath + " is not a directory");
    }
    
    // Check manifest file
    final File manifest = new File(directory, "manifest.json");
    if (manifest.exists() && !manifest.isFile())
    {
      throw new IllegalArgumentException("File manifest.json doesn't exists");
    }

    // Check key store
    final File keyStore = new File(keyStoreFilePath);
    if (keyStore.exists() && !keyStore.isFile())
    {
      throw new IllegalArgumentException("Keystore not found");
    }
    
    // Load key store
    final FileInputStream clientStoreIn = new FileInputStream(keyStore);
    final KeyStore clientStore = KeyStore.getInstance("PKCS12");
    clientStore.load(clientStoreIn, keyStorePassword.toCharArray());

    // Extract private key and certificate
    final Enumeration<String> aliases = clientStore.aliases();
    String alias = "";
    while (aliases.hasMoreElements())
    {
      alias = aliases.nextElement();
      if (clientStore.isKeyEntry(alias))
      {
        break;
      }
    }
    final PrivateKey key = (PrivateKey) clientStore.getKey(alias, keyStorePassword.toCharArray());
    final X509Certificate cert = (X509Certificate) clientStore.getCertificate(alias);

    // Load Apple certificate
    final InputStream appleCertIn = PassUtils.class.getResourceAsStream("/resources/AppleWWDRCA.cer");
    final CertificateFactory appleCertFactory = CertificateFactory.getInstance("X.509");
    final X509Certificate appleCert = (X509Certificate) appleCertFactory.generateCertificate(appleCertIn);

    // Signature
    final ContentSigner sha1Signer = new JcaContentSignerBuilder("SHA1withRSA").setProvider(BouncyCastleProvider.PROVIDER_NAME).build(key);

    final ASN1EncodableVector signedAttributes = new ASN1EncodableVector();
    final Attribute signingAttribute = new Attribute(CMSAttributes.signingTime, new DERSet(new DERUTCTime(new Date()))); 
    signedAttributes.add(signingAttribute);
    // Create the signing table
    final AttributeTable signedAttributesTable = new AttributeTable(signedAttributes);
    // Create the table table generator that will added to the Signer builder
    final DefaultSignedAttributeTableGenerator signedAttributeGenerator = new DefaultSignedAttributeTableGenerator(signedAttributesTable);

    List<X509Certificate> certList = new ArrayList<X509Certificate>();
    certList.add(appleCert);
    certList.add(cert);
    Store certs = new JcaCertStore(certList);

    final CMSSignedDataGenerator generator = new CMSSignedDataGenerator();
    generator.addSignerInfoGenerator(new JcaSignerInfoGeneratorBuilder(new JcaDigestCalculatorProviderBuilder().setProvider(
        BouncyCastleProvider.PROVIDER_NAME).build()).setSignedAttributeGenerator(signedAttributeGenerator).build(sha1Signer, cert));
    generator.addCertificates(certs);

    final CMSSignedData sigData = generator.generate(new CMSProcessableFile(manifest), false);
    final byte[] signedDataBytes = sigData.getEncoded();

    // Write signature
    final File signatureFile = new File(directoryPath, "signature");
    final FileOutputStream signatureOutputStream = new FileOutputStream(signatureFile);
    signatureOutputStream.write(signedDataBytes);
    signatureOutputStream.close();
  }
}
