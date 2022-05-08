""" Unit tests for content_to_dict.py filter """

import pytest
from ansible.errors import AnsibleFilterTypeError
from content_to_dict import content_to_dict


@pytest.mark.parametrize('content, linesep, wordsep, expected', [
    (r'test1 value1 \n test2 value2 ', r'\n', None, {'test1': 'value1', 'test2': 'value2'}),
    ('test3,value3|test4, value4  ', '|', ',', {'test3': 'value3', 'test4': 'value4'})
])
def test_content_to_dict(content, linesep, wordsep, expected):
    assert expected == content_to_dict(
        content, linesep=linesep, wordsep=wordsep
    )


@pytest.mark.parametrize('content', [([]), (None), (''), ({}), ('test')])
def test_content_to_dict_raised_exception(content):
    with pytest.raises(AnsibleFilterTypeError):
        assert content_to_dict(content)
