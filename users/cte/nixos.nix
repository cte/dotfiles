{ username, ... }:

{
  users.users.${username} = {
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC2WjMKEbeyih7x5Y8Tt62zwEHkKTxxb79ToBdklfyGBoFVZYtlbvvlwTzzlXkSP6wUw1r+dC3GcdMAaJbFJNlXoJwHEcqhBYOP5aaxdtEBNBlsr3dOkTi007e4G3AJ5EEUGgDblGPWxJZIqLQOzsEb7TT+KZC1kYQBZDpyGPo3ZfkkqKTn3amS1uKVEhP3CgMjjE/ThP36a0O8UgtwjS3zlTY/PDYfNW/QCd7WNT/zKcHku9k+f+wRmIejTioc0+QLdzgIPq4X0m7XEssh0dVF+fKvb7IdCmHyqjBfU6VN8a5u86kN/4ETZsz4n/9rnN2G322Mo1Su9fEi/a9UhGQjZ6qFv0jvBfj5RR0R+mD1Ta3zRQxGnNcx0580Hnrb3Bauc510M/4C5+atAQ/NNz/KOl6O8Bd3VdyFMAtLNynuDkNpYk9RcfroY9OjA+em3r0yw+b+mhGnD+xD5XjzeaY8TD4mnzqKE+kA+Nk2e0AXf5XUVnXwIaMiLKsbT14R+jk= ${username}@host"
    ];
  };
}
