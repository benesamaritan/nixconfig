{ ... }:

{
  age = {
    secrets.hashedPassword.file = ./../secrets/hashedPassword.age;
    identityPaths = [ "/home/bye/.ssh/id_rsa" ];
  };
}
