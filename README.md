# README

Generate checksum based on predefined rules.

### Install

The app can run on a Linux VM managed by Vagrant or directly via Docker. Here's how you can setup and run the app directly via Docker.

1. Run `cp acme.json.example acme.json` and `cp .env.example .env` to prepare config files.
2. Open `.env` and change the `APP_HOST` section to whatever URL you want to run the app on (`http://localhost` should work as well).
3. Build Docker images by running `docker-compose build`
4. Install yarn packages via `docker-compose run --rm app yarn install`
5. Create the database by running `docker-compose run --rm app rails db:setup`
6. Finally you can start the app via `docker-compose up`
7. Go to the URL you defined in step 2. and you should see the checksum calculation form.

### Known bugs

- Webpacker sometimes can forget building `app/javascript/packs/application.js` in development when you start the app from cold. To trigger the building phase, append an empty line to the end of this file to trigger a change in it's content and then save. Refresh the browser and all JavaScript should work.
