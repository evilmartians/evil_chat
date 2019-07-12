# Evil Chat

Code for a chat application from **"Modern Front-end in Rails"** three-part tutorial from [Evil Martians](https://evilmartians.com/). Read it here:

- [Part 1](https://evilmartians.com/chronicles/evil-front-part-1)
- [Part 2](https://evilmartians.com/chronicles/evil-front-part-2)
- [Part 3](https://evilmartians.com/chronicles/evil-front-part-3)

> An opinionated guide to modern, modular, component-based approach to handling your presentation logic in Rails that does not depend on any front-end framework. Follow our three-part tutorial to learn the bare minimum of up-to-date front-end techniques by example and finally make sense of it all.

The `master` branch contains the final code for the demo application with some light modifications that add SVG icons to demonstrate `postcss-inline-svg` plugin.

If you are looking for code that reflects application at the end of any part, take a look at:

- [part-1 branch](https://github.com/demiazz/evil_chat/tree/part-1) for the Part 1;
- [part-2 branch](https://github.com/demiazz/evil_chat/tree/part-2) for the Part 2;
- [part-3 branch](https://github.com/demiazz/evil_chat/tree/part-3) for the Part 3.

# Installation

```
$ cp config/database.yml.example config/database.yml

$ bin/rails credentials:edit

$ bundle install
$ bin/rails db:migrate
$ yarn install
$ brew install hivemind
$ hivemind Procfile.dev
```
