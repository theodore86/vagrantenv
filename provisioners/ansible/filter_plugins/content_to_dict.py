"""Ansible filter plugin """

import os
from ansible.errors import AnsibleFilterTypeError


class FilterModule(object):
    """ Jinja2 filter class """

    def filters(self):
        """ Register filters """
        return {
            'content_to_dict': content_to_dict
        }


def content_to_dict(content, linesep=os.linesep, wordsep=None, maxsplit=1):
    """ Convert a string to dictionary """
    try:
        _dict = dict(
            (k.strip(), v.strip())
            for line in content.split(linesep)
            for k, v in [line.strip().split(wordsep, maxsplit)]
        )
    except AttributeError:
        raise AnsibleFilterTypeError(
            'content should be string got: {!r}'
            .format(content)
        )
    except ValueError:
        raise AnsibleFilterTypeError(
            'content is format is malformed'
        )
    return _dict
