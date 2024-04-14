from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
from webdriver_manager.microsoft import EdgeChromiumDriverManager
from webdriver_manager.firefox import GeckoDriverManager
import FileUtil
import os


class BrowserOptions:

    def get_driver_path(self, browser):
        if browser == 'chrome':
            driver_path = ChromeDriverManager().install()
        elif browser == 'edge':
            driver_path = EdgeChromiumDriverManager().install()
        elif browser == 'firefox':
            driver_path = GeckoDriverManager().install()
        return driver_path

    def get_chromeoptions(self, headless=False):
        download_path = FileUtil.get_resource_directory('Download')
        try:
            os.mkdir(download_path)
        except OSError as error:
            print("Directory '%s' can not be created" % download_path)
        chrome_options = webdriver.ChromeOptions()
        chrome_options.add_argument('--disable-dev-shm-usage')
        chrome_options.add_argument('--inprivate')
        chrome_options.add_argument('--no-sandbox')
        chrome_options.add_argument('--disable-gpu')
        chrome_options.add_argument('--ignore-certificate-errors')
        chrome_options.add_experimental_option('excludeSwitches', ['enable-automation'])
        chrome_options.add_experimental_option('prefs', {
            'credentials_enable_service': False,
            'download.default_directory': download_path,
            'profile': {
                'password_manager_enabled': False,
                'download.prompt_for_download': False,
                'download.directory_upgrade': True
            }
        })
        if headless:
            chrome_options.add_argument("--headless")
        return chrome_options

    def get_edgeoptions(self, headless=False):
        download_path = FileUtil.get_resource_directory('Download')
        try:
            os.mkdir(download_path)
        except OSError as error:
            print("Directory '%s' can not be created" % download_path)
        edge_options = webdriver.EdgeOptions()
        edge_options.add_argument('--disable-dev-shm-usage')
        edge_options.add_argument('--inprivate')
        edge_options.add_argument('--no-sandbox')
        edge_options.add_argument('--disable-gpu')
        edge_options.add_argument('--ignore-certificate-errors')
        edge_options.add_experimental_option('excludeSwitches', ['enable-automation'])
        edge_options.add_experimental_option('prefs', {
            'credentials_enable_service': False,
            'download.default_directory': download_path,
            'profile': {
                'password_manager_enabled': False,
                'download.prompt_for_download': False,
                'download.directory_upgrade': True,
            }
        })
        if headless:
            edge_options.add_argument("--headless")
        return edge_options

    def get_firefoxoptions(self, headless=False):
        download_path = FileUtil.get_resource_directory('Download')
        try:
            os.mkdir(download_path)
        except OSError as error:
            print("Directory '%s' can not be created" % download_path)
        firefox_options = webdriver.FirefoxOptions()
        firefox_options.add_argument('--disable-dev-shm-usage')
        firefox_options.add_argument('--no-sandbox')
        firefox_options.add_argument('--ignore-certificate-errors')
        firefox_options.add_argument('--disable-gpu')
        firefox_options.add_argument('--disable-infobars')
        firefox_options.set_preference('dom.webnotifications.enabled', False)
        firefox_options.set_preference('browser.download.dir', download_path)
        firefox_options.set_preference('browser.download.folderList', 2)
        firefox_options.set_preference('browser.helperApps.neverAsk.saveToDisk', '*/*')
        if headless:
            firefox_options.add_argument("--headless")
        return firefox_options
