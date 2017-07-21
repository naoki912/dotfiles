#!/usr/bin/env python

import os.path
import argparse


'''
cowsay
'''


memo_file_path = os.path.expanduser('~/.memo')

args = None


def main():
    global args
    args = init_args()

    if args.add is not None:
        add_memo()
    if args.rm is not None:
        rm_memo()
    if args.init:
        init_memo()

    list_memo()

    return None


def init_args():
    parser = argparse.ArgumentParser()
    group = parser.add_mutually_exclusive_group()

    parser.add_argument('-l', '--list', action='store_true', help='メモ一覧を表示')

    group.add_argument('-a', '--add', type=str, dest='add', help='追加するメモ')
    group.add_argument('-r', '--rm', type=int, dest='rm', help='削除したいメモの番号')
    group.add_argument('--init', action='store_true', help='メモファイルを作成')

    return parser.parse_args()


def is_memo_file_exists():
    if not os.path.exists(memo_file_path):
        print(memo_file_path + ": ファイルが見つからないよ")
        return False
    elif not os.path.isfile(memo_file_path):
        print(memo_file_path + ": ファイル形式じゃないよ")
        return False
    else:
        return True


def list_memo():
    if not is_memo_file_exists():
        return

    print(' === めもいちらん ===')

    # ToDo 空行があった場合に表示しない
    with open(memo_file_path, 'r') as f:
        for i, line in enumerate(f):
            print(str(i) + ': ' + line, end='')

    print(' ======')

    return None


def add_memo():
    if is_memo_file_exists():
        with open(memo_file_path, 'a') as f:
            f.write(args.add)
            f.write('\n')

    return None


def rm_memo():
    if is_memo_file_exists():

        origin = {}

        with open(memo_file_path, 'r') as f:
            for i, line in enumerate(f):
                origin.update({i: line})

            if args.rm in origin:
                origin.pop(args.rm)
            else:
                print('そんなメモ番号は存在しないよ！')
                return None

        with open(memo_file_path, 'w') as f:
            for i in origin.values():
                f.writelines(i)

    return None


def editor_memo():
    '''
    ToDo 環境変数EDITORを確認して、エディタが設定されていたらそのエディタで.memoファイルを開く
    '''
    pass


def init_memo():
    if is_memo_file_exists():
        print(memo_file_path + ": 初期化済みです")
        return None

    os.mknod(memo_file_path)
    print(memo_file_path + ": ファイルを作成しました")

    return None


if __name__ == '__main__':
    main()
