""" Required by pytest, adds path to PYTHONPATH """

class FilterModule(object):
    """ Jinja2 filter class """

    def filters(self):
        """ Register filters """
        return {
          'conftest': lambda: True
        }
