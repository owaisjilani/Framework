import os
from robot.api.deco import keyword


@keyword('Get Resource Directory')
def get_resource_directory(directory_name, file=''):
    project_root = os.path.dirname(
        os.path.dirname(os.path.abspath(__file__)))  # Go up one level to the project root
    download_path = os.path.join(project_root, 'Resources', directory_name, file)
    return download_path


@keyword('Get Project Directory')
def get_project_directory(directory_name, file=''):
    project_root = os.path.dirname(
        os.path.dirname(os.path.abspath(__file__)))  # Go up one level to the project root
    download_path = os.path.join(project_root, directory_name, file)
    return download_path




