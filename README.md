# cf-pass

__A pass generation library for Coldfusion__

# How to install

### Lucee 4

Download the latest version [here](https://github.com/jbvanzuylen/cf-pass/releases/download/v0.3.0/cf-pass-ext.zip)

__Install as an extension__

* Connect to the Web Administration
* Go to `Extension > Application`
* Scroll down to the bottom of the page
* Click on `Browse` button in the `Upload new extension` section
* Select the ZIP file you have downloaded above
* Hit the `Upload` button and follow the instructions

__Manual installation__

* Unzip the file you have downloaded above
* Copy the `.jar` files from the `lib` folder to the `WEB-INF\railo\lib` directory in your web root
* Copy the `.cfm` files from the `functions` folder to the `WEB-INF\railo\library\function` directory in your web root
* Copy the `.cfc` file from the `components` folder to the `WEB-INF\railo\components\pass` directory in your web root
