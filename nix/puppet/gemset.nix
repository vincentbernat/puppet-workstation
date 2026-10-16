{
  base64 = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "27337aeabad6ffae05c265c450490628ef3ebd4b67be58257393227588f5a97b";
      type = "gem";
    };
    version = "0.3.0";
  };
  benchmark = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "465df122341aedcb81a2a24b4d3bd19b6c67c1530713fd533f3ff034e419236c";
      type = "gem";
    };
    version = "0.5.0";
  };
  concurrent-ruby = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "b2f1be836e968ccc78ccfce277ea79c72a88633f22306782c16ff23fb415d1e1";
      type = "gem";
    };
    version = "1.3.8";
  };
  deep_merge = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "83ced3a3d7f95f67de958d2ce41b1874e83c8d94fe2ddbff50c8b4b82323563a";
      type = "gem";
    };
    version = "1.2.2";
  };
  facter = {
    dependencies = ["hocon" "thor"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "17d561xf4s5016fm9jkfkkafn6660g04fz1yp5xfvkb0j4xj32mp";
      type = "gem";
    };
    version = "4.10.0";
  };
  faraday = {
    dependencies = ["faraday-net_http" "json" "logger"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "3be0eff0187ed913a1b4f679e9fcfe845b542cdd4f75b76cd6181a4ae1335fff";
      type = "gem";
    };
    version = "2.15.0";
  };
  faraday-follow_redirects = {
    dependencies = ["faraday"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "5cde93c894b30943a5d2b93c2fe9284216a6b756f7af406a1e55f211d97d10ad";
      type = "gem";
    };
    version = "0.5.0";
  };
  faraday-net_http = {
    dependencies = ["net-http"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "2e7094c34e38754ee048cc3df47376f8657005d9375f8473bce1c3b526a22e36";
      type = "gem";
    };
    version = "3.5.0";
  };
  fast_gettext = {
    dependencies = ["prime"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1i9anyxdsz3lxlg9cg2dcad1fwykz4lr45v2q3nwjp477b1q8k4w";
      type = "gem";
    };
    version = "3.1.0";
  };
  fiddle = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "7fa8ee3627271497f3add5503acdbc3f40b32f610fc1cf49634f083ef3f32eee";
      type = "gem";
    };
    version = "1.1.8";
  };
  forwardable = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "f1cd40cc9812937980e1c76f1aa053660990a7c9b6a98fc37d945468afcce838";
      type = "gem";
    };
    version = "1.4.0";
  };
  getoptlong = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "fd23f07397b994bf9310d4531cfdb4332629a9b8e8c9c457c32b7edf5bf21ba5";
      type = "gem";
    };
    version = "0.2.1";
  };
  hocon = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "e71023ed7c56ae780ec34c0ce7789a233bcead08c045d50bc7b3af40f5afcd80";
      type = "gem";
    };
    version = "1.4.0";
  };
  json = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "3ce7ccf8fde58960177a3a756c31f292a4c1e1dedee884547096a5b0604e3bd8";
      type = "gem";
    };
    version = "3.1.0";
  };
  librarian-puppet = {
    dependencies = ["librarianp" "puppet_forge" "rsync"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "e55cb770ec66d0e97076a1fc061cdc6d7d83f642de9dd63f6a4a1678af1f9a6e";
      type = "gem";
    };
    version = "6.0.0";
  };
  librarianp = {
    dependencies = ["thor"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "660b8a9d82317715d5ef4275bd55a013abbe97cb8f4656542dd5807b56f35649";
      type = "gem";
    };
    version = "1.2.0";
  };
  locale = {
    dependencies = ["fiddle"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1c6803e8aa6bdb2c29e91945d095050601bf6d58474993575adf6f3b89b32ef4";
      type = "gem";
    };
    version = "2.1.5";
  };
  logger = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "196edec7cc44b66cfb40f9755ce11b392f21f7967696af15d274dde7edff0203";
      type = "gem";
    };
    version = "1.7.0";
  };
  minitar = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "38db0cfb6f3801017946cdcd8dc53f2cf3fd41ff752892312bf9a1639c9ea23e";
      type = "gem";
    };
    version = "1.1.0";
  };
  multi_json = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "13pabgwf4qd5qn4sl7ci15g5ql038n5z0psip9xabnsbypm32m94";
      type = "gem";
    };
    version = "1.21.2";
  };
  net-http = {
    dependencies = ["net-protocol" "uri"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1a2ff6e37a05724973c43f2bf7bf105f59c36a4cd0a7e9b1c021a0a566987c27";
      type = "gem";
    };
    version = "0.10.0";
  };
  net-protocol = {
    dependencies = ["timeout"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "f9f90c8c6f64794a45160bf422177a336db12809de3beeeaa26b88fcd2e8c853";
      type = "gem";
    };
    version = "0.4.0";
  };
  ostruct = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "95a2ed4a4bd1d190784e666b47b2d3f078e4a9efda2fccf18f84ddc6538ed912";
      type = "gem";
    };
    version = "0.6.3";
  };
  prime = {
    dependencies = ["forwardable" "singleton"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "4d755ebf7c2994a6f3a3fee0d072063be3fff2d4042ebff6cd5eebd4747a225e";
      type = "gem";
    };
    version = "0.1.4";
  };
  puppet = {
    dependencies = ["concurrent-ruby" "deep_merge" "facter" "fast_gettext" "getoptlong" "locale" "multi_json" "puppet-resource_api" "scanf" "semantic_puppet"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0fia3ji6isnqz4a31aq8k4nd8p7vkxn80hhgqfdc8kkrba7xxxgj";
      type = "gem";
    };
    version = "8.10.0";
  };
  puppet-resource_api = {
    dependencies = ["hocon"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1j6gdm7r89qzwn2vvf7yks53s56yp5gwyc8xycmhwk7503kazdfl";
      type = "gem";
    };
    version = "1.9.2";
  };
  puppet_forge = {
    dependencies = ["base64" "faraday" "faraday-follow_redirects" "minitar" "semantic_puppet"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "9cde4841a7a6950afeb0c4fec02449931179863918c0a6e6909cb2a6c6998a0c";
      type = "gem";
    };
    version = "6.2.0";
  };
  racc = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "4a7f6929691dbec8b5209a0b373bc2614882b55fc5d2e447a21aaa691303d62f";
      type = "gem";
    };
    version = "1.8.1";
  };
  rsync = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "bbdb69727a7cf17a26be5dce197d15957dfaf8ed4814811da6b1ef17f0110b5d";
      type = "gem";
    };
    version = "1.0.9";
  };
  ruby-augeas = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "002bd237d8dce4b918384cc3043254bf5264efe81f663d1c9ac7b41cbe4df8d2";
      type = "gem";
    };
    version = "0.6.0";
  };
  scanf = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "533db7f7e5acafea1a145d6c5329cef667a58fbcb7d64379a808ff1199ee1b00";
      type = "gem";
    };
    version = "1.0.0";
  };
  semantic_puppet = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "15ff5b48d7f856549eb66b927a8894d3668b211970c9d7dc07dd4db57f5c7a96";
      type = "gem";
    };
    version = "1.1.1";
  };
  singleton = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "83ea1bca5f4aa34d00305ab842a7862ea5a8a11c73d362cb52379d94e9615778";
      type = "gem";
    };
    version = "0.3.0";
  };
  syslog = {
    dependencies = ["logger"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "c4c38ae982fe72903ec41094b5e5f2dcbbc66f510d0225c9702e5e980d827472";
      type = "gem";
    };
    version = "0.4.0";
  };
  thor = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0k7j2wn14h1pl4smibasw0bp66kg626drxb59z7rzflch99cd4rg";
      type = "gem";
    };
    version = "1.2.2";
  };
  timeout = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "78f57368a7e7bbadec56971f78a3f5ecbcfb59b7fcbb0a3ed6ddc08a5094accb";
      type = "gem";
    };
    version = "0.6.1";
  };
  uri = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "89292e98eabbef6248b0a0ed5e7e398e152f83f17560023a6d94a7f492b169fb";
      type = "gem";
    };
    version = "1.1.2";
  };
}
