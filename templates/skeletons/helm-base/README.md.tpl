# ${{values.name}}

${{values.description}}

## ⎈ Helm Chart Template

This skeleton provides a basic Helm chart structure for deploying applications to Kubernetes.

### Chart Structure

```
helm-chart/
├── Chart.yaml              # Chart metadata and dependencies
├── values.yaml             # Default configuration values
├── templates/
│   ├── deployment.yaml     # Kubernetes deployment
│   ├── service.yaml        # Kubernetes service
│   ├── ingress.yaml        # Ingress configuration
│   ├── configmap.yaml      # Configuration map
│   ├── secret.yaml         # Secrets
│   ├── serviceaccount.yaml # Service account
│   ├── _helpers.tpl        # Template helpers
│   └── tests/              # Chart tests
└── .helmignore             # Files to ignore during packaging
```

### Quick Start

1. **Customize Chart.yaml:**
   - Update name, description, and version
   - Add keywords and maintainer information

2. **Configure values.yaml:**
   - Set default values for your application
   - Configure image repository and tag
   - Set resource limits and requests

3. **Template files:**
   - Modify templates to match your application needs
   - Update selectors and labels
   - Configure environment-specific values

### Installation

1. **Install the chart:**
   ```bash
   helm install my-release .
   ```

2. **Install with custom values:**
   ```bash
   helm install my-release . -f my-values.yaml
   ```

3. **Upgrade the release:**
   ```bash
   helm upgrade my-release .
   ```

4. **Uninstall the release:**
   ```bash
   helm uninstall my-release
   ```

### Configuration

The following table lists the configurable parameters and their default values:

| Parameter | Description | Default |
|-----------|-------------|---------|
| `image.repository` | Container image repository | `nginx` |
| `image.tag` | Container image tag | `latest` |
| `image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `replicaCount` | Number of replicas | `1` |
| `service.type` | Kubernetes service type | `ClusterIP` |
| `service.port` | Service port | `80` |
| `ingress.enabled` | Enable ingress | `false` |
| `resources.limits.cpu` | CPU limit | `100m` |
| `resources.limits.memory` | Memory limit | `128Mi` |

### Development

1. **Lint the chart:**
   ```bash
   helm lint .
   ```

2. **Template and validate:**
   ```bash
   helm template . | kubectl apply --dry-run=client -f -
   ```

3. **Package the chart:**
   ```bash
   helm package .
   ```

4. **Test the chart:**
   ```bash
   helm test my-release
   ```

### Best Practices

- Use semantic versioning for chart versions
- Include resource limits and requests
- Use ConfigMaps and Secrets for configuration
- Add readiness and liveness probes
- Include RBAC resources when needed
- Test charts with different value combinations
- Document all configurable parameters

### Dependencies

To add chart dependencies, update `Chart.yaml`:

```yaml
dependencies:
  - name: postgresql
    version: "12.1.2"
    repository: "https://charts.bitnami.com/bitnami"
    condition: postgresql.enabled
```

Then run:
```bash
helm dependency update
```

### Repository Integration

This chart can be:
- Published to a Helm repository
- Stored in Git repositories
- Distributed via OCI registries
- Integrated with GitOps workflows

## 🔧 Customization

Modify the templates and values to match your specific application requirements. The chart follows Helm best practices and can be extended as needed.