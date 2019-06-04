Install Porter

```
curl https://cdn.deislabs.io/porter/latest/install-mac.sh | bash
```

Add Porter to path.

```
export PATH=$PATH:~/.porter
```

Install Terraform mixin.

```
porter mixin install terraform --feed-url https://cdn.deislabs.io/porter/atom.xml
```

```
mkdir clouddrive/porter
cd clouddrive/porter
```

```
porter create
```


```
porter build
```

```
porter list
```


