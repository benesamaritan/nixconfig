{ nixpkgs, ... }:

let

	username = "bye";
	description = "Bayu Saputro";
	hashPasswd = "$6$KyNQWAqeKj9uX3G6$zoWMV0vtTLO1cEbnUDKnFGSIy.MGPnoCDQ3mmZisqx2qrr.Ywyp3ajoLhni2OQTWZ4kKAVMNcKSuKzIWPmhx7.";
	system = "x86_64-linux";
	pkgs = import nixpkgs {
	  inherit system;
	  config.allowUnfree = true;
	};
	hostname = "sol";
	shell = "fish";
	timezone = "Asia/Jakarta";
	defaultLocale = "en_US.UTF-8";
	extraLocale = "id_ID.UTF-8";
	groups = [
	  "networkmanager"
	  "wheel"
	];
	xkb = {
	  layout = "us";
	  variant = "";
	};
	git = {
	  user = "benesamaritan";
	  email = "243715333+benesamaritan@users.noreply.github.com";
	};

in { }
