import os
import re

from jinja2 import Environment, FileSystemLoader


env = Environment(loader=FileSystemLoader('/'))

template = env.get_template('config.j2')

kwargs = {
    'nameserver': os.environ.get('NAMESERVER', os.environ.get('SYSTEM_NAMESERVER', '127.0.0.1')),
    'services': []
}

for k in os.environ:
    services = re.findall("^BACKEND\\[(.*)\\]$", k)
    if len(services) > 0:
        service = services[0]

        kwargs['services'].append({
            'name': service,
            'ecs_srv': os.environ.get('BACKEND[{}]'.format(service)),
            'port': os.environ.get('PORT[{}]'.format(service)),
            'count': '1',
        })

config = template.render(kwargs)

print(config)
