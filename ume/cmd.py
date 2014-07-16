# -*- coding: utf-8 -*-
import logging as l
import argparse

from ume.utils import (
    save_mat,
    dynamic_load,
)


def parse_args():
    p = argparse.ArgumentParser(
        description='CLI interface UME')
    p.add_argument('--config', dest='inifile', default='config.ini')

    subparsers = p.add_subparsers(
        dest='subparser_name',
        help='sub-commands for instant action')

    f_parser = subparsers.add_parser('feature')
    f_parser.add_argument('-n', '--name', type=str, required=True)

    subparsers.add_parser('validation')
    subparsers.add_parser('prediction')

    return p.parse_args()


def run_feature(args):
    klass = dynamic_load(args.name)
    result = klass()
    save_mat(args.name, result)


def main():
    l.basicConfig(format='%(asctime)s %(message)s', level=l.INFO)
    args = parse_args()
    if args.subparser_name == 'validate':
        pass
    elif args.subparser_name == 'predict':
        pass
    elif args.subparser_name == 'feature':
        run_feature(args)
    else:
        raise RuntimeError("No such sub-command.")
