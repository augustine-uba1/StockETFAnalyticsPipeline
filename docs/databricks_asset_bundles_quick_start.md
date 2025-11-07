# Databricks Asset Bundles — Quick Start

A very short guide to initialize and use Databricks Asset Bundles.

Basic commands (run from your project directory):

```powershell
databricks auth login --host https://adb-url.azuredatabricks.net

databricks bundle init
```

Notes:
- Make sure the Databricks CLI (with Bundles extension) is installed and configured.
- After `databricks auth login` you'll be authenticated to your workspace and can run `databricks bundle` commands.

Example `bundle.yml` (very small):

```yaml
name: sample-bundle
version: 0.1.0
assets:
	- path: notebooks/
		type: notebook
	- path: jobs/
		type: job
```

Common bundle commands (examples):

```powershell
# Authenticate to your workspace
databricks auth login --host https://adb-URL.azuredatabricks.net

# Initialize a new bundle in the current directory
databricks bundle init

# (Optional) Build, list or deploy a bundle
databricks bundle build
databricks bundle list
databricks bundle deploy --target <workspace-or-target-name>
databricks bundle deploy -t dev
databricks bundle validate
```