# Author: Owais Jilani
# Creation date: 15-Sep-2023
from cryptography.fernet import Fernet
from robot.api.deco import keyword
import base64
import os


class CryptoService:

    # Function to generate a custom Fernet key.
    # Secret must be set prior to running this Utility either in System Environment Variable if running locally or as a Secret variable if running via Jenkins.
    # Rule for setting Secret : Atleast 22 Character and contains only Alphabets (Lowercase and Uppercase both are allowed) 
    @keyword
    def generateSecretKey(self):
        try:
            key = os.environ.get('secret', 'ThisIsMySecretKeyExample')
            key = key.encode("ascii")
            key = base64.b64encode(key)
            key = base64.urlsafe_b64encode(key)
            return key
        except Exception as e:
            return f"Error: {str(e)}"

    # Function to decrypt a message using a Fernet cipher suite
    @keyword
    def decryptMsg(self, encrypted_message):
        if "#enc#_" in encrypted_message:
            encrypted_message = encrypted_message.replace("#enc#_", "")
            try:
                key = self.generateSecretKey()
                cipher_suite = Fernet(key)
                decrypted_message = cipher_suite.decrypt(encrypted_message)
                return decrypted_message.decode()
            except Exception as e:
                return f"Error: {str(e)}"
        else:
            return encrypted_message

    # Function to encrypt a message
    @keyword
    def encryptMsg(self, messageToEncrypt):
        try:
            key = self.generateSecretKey()
            cipher_suite = Fernet(key)
            encrypted_message = cipher_suite.encrypt(messageToEncrypt.encode())
            return encrypted_message
        except Exception as e:
            return f"Error: {str(e)}"
