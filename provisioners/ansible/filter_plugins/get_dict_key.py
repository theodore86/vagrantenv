""" Ansible filter plugin """

from ansible.errors import AnsibleFilterTypeError


class FilterModule:
    """ Jinja2 filter class """

    def filters(self):
        """ Register filters """
        return {
            'get_dict_key': get_dict_key
        }


def get_dict_key(_dict, value):
    """ Get dictionary key from value """
    try:
        for key, _value in _dict.items():
            if _value == value:
                return key
    except (AttributeError, TypeError) as exc:
        raise AnsibleFilterTypeError(
            f"{_dict!r} is not of a dictionary type"
        ) from exc
    return None
