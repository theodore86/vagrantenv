""" Unit tests for get_dict_key filter """

import pytest
from ansible.errors import AnsibleFilterTypeError
from get_dict_key import get_dict_key


@pytest.mark.parametrize(
    'param, value, expected',
    [({'x': 2}, 2, 'x'), ({'y': 'word'}, 'word', 'y'), ({}, 2, None)]
)
def test_get_dict_key(param, expected, value):
    actual = get_dict_key(param, value)
    assert actual == expected


@pytest.mark.parametrize('param, value', [([], 2), ((), 3), (1, 'test'), (None, 'test2')])
def test_get_dict_key_raised_exceptions(param, value):
    with pytest.raises(AnsibleFilterTypeError):
        assert get_dict_key(param, value)
