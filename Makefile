create_env:
	cp .env.example .env

test:
	ansible all -m ping -i hosts.ini --ssh-common-args='-o PubkeyAuthentication=no -o PreferredAuthentications=password'

run:
	@set -a && . ./.env && set +a && \
	ansible-playbook -i hosts.ini setup.yml --ssh-common-args='-o PubkeyAuthentication=no -o PreferredAuthentications=password'

