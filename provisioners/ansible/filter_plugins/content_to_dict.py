"""Ansible filter plugin """

import os
from ansible.errors import AnsibleFilterTypeError


class FilterModule:
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
    except AttributeError as exc:
        raise AnsibleFilterTypeError(
            f'content should be string got: {content!r}'
        ) from exc
    except ValueError as exc:
        raise AnsibleFilterTypeError(
            'content format is malformed'
        ) from exc
    return _dict
