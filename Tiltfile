commit_sha = str(local('git rev-parse --short HEAD')).strip()
extra_tag = 'mezzio-kafka-skeleton:sha-' + commit_sha

docker_build(
    'trainer',
     extra_tag=extra_tag,
     context='.',
     live_update=[
        sync('.', '/var/www/html'),
     ]
)

k8s_yaml(helm(
    './helm/mezzio-kafka-skeleton',
    namespace='mezzio-kafka-skeleton'
))
