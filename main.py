#!/usr/bin/python3
import requests

def main():
    try:
        uri = 'http://192.168.25.96'
        w   = open('common.txt', 'r')
        dic = []

        for w in w.readlines():
            dic.append(w.replace('\n', ''))

        for x in dic:
            url    = f'{uri}/{x}'
            r      = requests.get(url) 

            if r.status_code == 200:
                resp = f'{r.status_code} {uri}/{x}'
                print(resp)

    except Exception as err:
        print(err)

if __name__ == '__main__':
    main()
