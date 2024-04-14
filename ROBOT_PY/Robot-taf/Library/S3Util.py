# Author: Owais Jilani
# Creation date: 13-January-2024
from robot.api.deco import keyword
import boto3


class S3Util:

    def _get_session(self, accesskey, secretkey):
        session = boto3.Session(aws_access_key_id=accesskey, aws_secret_access_key=secretkey)
        return session.resource('s3')

    @keyword('Upload To S3')
    def upload_to_s3(self, accesskey, secretkey, file, bucket, key):
        s3 = self._get_session(accesskey, secretkey)
        try:
            s3.meta.client.upload_file(file, bucket, key)
            print(f"File uploaded successfully to '{key}' in S3 bucket '{bucket}'.")
        except Exception as e:
            print(f"Error: {e}")

    @keyword('Get Files From S3')
    def get_files_from_s3(self, accesskey, secretkey, bucket, base):
        s3 = self._get_session(accesskey, secretkey)
        try:
            objects = s3.meta.client.list_objects(Bucket=bucket, Prefix=base)
            files = [obj['Key'] for obj in objects.get('Contents', [])]
            print(f"Files in folder '{base}' in S3 bucket '{bucket}':")
            for file in files:
                print(f"- {file}")
            # Return the list of file names
            return files
        except Exception as e:
            print(f"Error: {e}")
            return None

    @keyword('Download Files From S3')
    def download_files_from_s3(self, accesskey, secretkey, bucket, file_key, download_path):
        session = boto3.Session(aws_access_key_id=accesskey, aws_secret_access_key=secretkey)
        s3 = session.client('s3')
        try:
            s3.download_file(bucket, file_key, download_path)
            print(f"Downloaded file '{file_key}' from S3 to '{download_path}'")
            return True
        except Exception as e:
            print(f"Error: {e}")
            return False
