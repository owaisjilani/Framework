import requests
from robot.api.deco import keyword


@keyword('Send Get Request')
def send_get_request(base_url, relative_url, cookies, dependant_dict, is_dependant):
    if is_dependant == "true":
        relative_url_list = []
        update_relative_url = relative_url.split('/')
        for r_path in update_relative_url:
            if r_path.startswith("_"):
                var = r_path[1:]
                for key, value in dependant_dict.items():
                    if key == var:
                        relative_url_list.append(value)
            else:
                relative_url_list.append(r_path)
        updated_relative_url = '/'.join(relative_url_list)
        print(updated_relative_url)
        url = base_url + updated_relative_url
        r = requests.get(url=url, headers=cookies)
        return r.status_code, r.json()
    else:
        url = base_url + relative_url
        r = requests.get(url=url, headers=cookies)
        return r.status_code, r.json()


@keyword('Send Post Request')
def send_post_request(base_url, relative_url, request_body, cookies, dependant_dict, is_dependant, file=None):
    if is_dependant == "true":
        relative_url_list= []
        update_relative_url = relative_url.split('/')
        for r_path in update_relative_url:
            if r_path.startswith("_"):
                var = r_path[1:]
                for key,value in dependant_dict.items():
                    if key == var:
                        relative_url_list.append(value)
            else:
                relative_url_list.append(r_path)
        updated_relative_url = '/'.join(relative_url_list)
        print(updated_relative_url)
        url = base_url + updated_relative_url
        r = requests.post(url=url, headers=cookies, data=request_body, files=file)
        return r.status_code, r.json()
    else:
        url = base_url + relative_url
        r = requests.post(url=url, headers=cookies, data=request_body, files=file)
        return r.status_code, r.json()


@keyword('Send Put Request')
def send_put_request(base_url, relative_url, request_body, cookies, dependant_dict, is_dependant, file=None):
    if is_dependant == "true":
        relative_url_list = []
        update_relative_url = relative_url.split('/')
        for r_path in update_relative_url:
            if r_path.startswith("_"):
                var = r_path[1:]
                for key, value in dependant_dict.items():
                    if key == var:
                        relative_url_list.append(value)
            else:
                relative_url_list.append(r_path)
        updated_relative_url = '/'.join(relative_url_list)
        print(updated_relative_url)
        url = base_url + updated_relative_url
        r = requests.put(url=url, headers=cookies, data=request_body, files=file)
        return r.status_code, r.json()
    else:
        url = base_url + relative_url
        r = requests.put(url=url, headers=cookies, data=request_body, files=file)
        return r.status_code, r.json()


@keyword('Send Delete Request')
def send_delete_request(base_url, relative_url, request_body, cookies, dependant_dict, is_dependant, file=None):
    if is_dependant == "true":
        relative_url_list = []
        update_relative_url = relative_url.split('/')
        for r_path in update_relative_url:
            if r_path.startswith("_"):
                var = r_path[1:]
                for key, value in dependant_dict.items():
                    if key == var:
                        relative_url_list.append(value)
            else:
                relative_url_list.append(r_path)
        updated_relative_url = '/'.join(relative_url_list)
        print(updated_relative_url)
        url = base_url + updated_relative_url
        r = requests.delete(url=url, headers=cookies, data=request_body, files=file)
        return r.status_code, r.json()
    else:
        url = base_url + relative_url
        r = requests.delete(url=url, headers=cookies, data=request_body, files=file)
        return r.status_code, r.json()
