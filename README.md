# terraform_base_template

### Step 1. Create .env file

```
make env
```

Open in editor

```
nano .env
```

Change variables to realy.

If you use different plugins directory, choose PLUGINS_DIR variable.

### Step 2. Download proxmox plugin

Use [last release](https://github.com/Telmate/terraform-provider-proxmox/releases "proxmox provider") of proxmox provider.

Change ``$VERSION`` .env variable to last provider version number.

Use make for download and install.

Download provider:

```
make wget
```

Unpack archive:

```
make zip
```

Install provider:

```
make provider
```

### Step 3. Init variables

```
make vars
```

### Step 4. Launch VM creation

```
make init
```

```
make plan
```

```
make
```
