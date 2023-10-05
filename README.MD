# WIS DevOps Test
Default WordPress project main repository. Installs WordPress with pre-built custom theme https://github.com/yuriipavlov/wis-test-theme and few plugins using GitHub Actions.

## How to use
### Requirements
- PHP v8.0
- Nginx
- MySQL

### Steps
1. Configure the server
- Install Requirements
- Add SSH public key to authorized_keys file

2. Add repository variables and secrets:

- `SSH_PRIVATE_KEY` - Your private SSH key, use secret
- `SERVER_USER` - deploy server username
- `SERVER_IP`- deploy server IP address
- `SERVER_PATH` - public folder path on the server
- `SERVER_PORT` - server SSH port

3. After each push to `main` branch runs GitHub Action with steps:
  - Build composer
  - Build node `*.css` and `*.js` files
  - Deploy

## Backups
The system has automatic backups. Launched by a cronjob. By default, daily and weekly backups work. With a retention period of 7 and 31 days, respectively. You can customize the frequency and content of backups yourself.


1. Edit `bash/start-backup.sh`
2. Run 'WordPress project Backup' GitHub Action to push script file to server
3. Backup will run automatically in GitHub Action job
4. Check crontab file in `crontab -e` - change cronjob time if it needs.

Backups will appear in the `~/backups` folder, logs in the `~/logs` folder
