# frozen_string_literal: true

tiers_1 = %w[x86_64-darwin x86_64-linux-gnu]
tiers_2 = %w[aarch64-darwin aarch64-linux-gnu aarch64-linux-musl arm-linux-gnueabihf i386-linux-gnu i386-linux-musl x86_64-linux-musl x86_64-openbsd x86_64-freebsd]
platforms = tiers_1 + tiers_2

platforms.each do |platform|
  system("docker run --rm -it -v $PWD:/workspace -w /workspace crystallang/crystal:1.7.3-alpine crystal build src/cli.cr --release --static --no-debug -o bin/miniss-#{platform} --cross-compile --target #{platform}")
end
