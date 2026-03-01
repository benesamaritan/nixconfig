{ ... }:

{
  age = {
    secrets.master.file = ./../secrets/master.age;
    secrets.github-token.file = ./../secrets/github-token.age;
    identityPaths = [
      "/home/bye/.ssh/id_rsa"
      "/home/bye/.ssh/id_ed25519"
    ];
  };
}
