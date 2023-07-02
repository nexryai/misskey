npm -g i pnpm

git submodule update --init
NODE_ENV=production pnpm install --frozen-lockfile

cp .config/example.yml .config/default.yml
nano .config/default.yml