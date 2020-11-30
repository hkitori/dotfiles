#!/usr/bin/env python3

# Prerequisite:
#   sudo apt-get install chromium-chromedriver
# How to use:
#   #!/bin/bash
#   export DISPLAY=':0';
#   cd ~/bin/ || exit
#   python3 sync_mf.py "id" "password";

from selenium import webdriver
import logging
import time
import sys
args = sys.argv

_format = "%(asctime)s %(levelname)s %(name)s :%(message)s"
logging.basicConfig(filename="moneyforward_reload_account.log", level=logging.DEBUG, format=_format)
global driver
driver = None

def login(email,password):
    driver.get("https://moneyforward.com/users/sign_in")
    time.sleep(3)
    driver.find_element_by_xpath("//*[@id='sign_in_session_service_email']").send_keys(email)
    driver.find_element_by_xpath("//*[@id='sign_in_session_service_password']").send_keys(password)
    driver.find_element_by_xpath("//*[@id='login-btn-sumit']").click()
    time.sleep(3)

def open_accounts_page():
    driver.get("https://moneyforward.com/accounts")

def click_reloads():
    elms = driver.find_elements_by_xpath("//input[@data-disable-with='更新']")
    for elm in elms:
        elm.click()
        time.sleep(0.5)
    time.sleep(5)

if __name__ == '__main__':
    try:
        driver = webdriver.Chrome(executable_path="/usr/bin/chromedriver")  # local
        login(args[1], args[2])
        open_accounts_page()
        click_reloads()
        logging.info("DONE")
    except Exception as e:
        logging.error(e)
    finally:
        driver.quit()

