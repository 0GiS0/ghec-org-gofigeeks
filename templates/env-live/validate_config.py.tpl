#!/usr/bin/env python3
"""
Configuration validation script for environment configurations.
"""
import os
import sys
import yaml
from pathlib import Path


def validate_config(config_path):
    """Validate a configuration file."""
    try:
        with open(config_path, "r") as f:
            config = yaml.safe_load(f)

        # Basic validation
        required_fields = ["environment", "service_name", "version"]
        for field in required_fields:
            if field not in config:
                print(f"❌ Missing required field: {field}")
                return False

        # Validate database config
        if "database" in config:
            db_config = config["database"]
            required_db_fields = ["host", "port", "name"]
            for field in required_db_fields:
                if field not in db_config:
                    print(f"❌ Missing database field: {field}")
                    return False

        print(f"✅ Configuration {config_path} is valid")
        return True

    except yaml.YAMLError as e:
        print(f"❌ YAML parsing error in {config_path}: {e}")
        return False
    except FileNotFoundError:
        print(f"❌ Configuration file not found: {config_path}")
        return False


def main():
    """Main validation function."""
    if len(sys.argv) > 1:
        # Validate specific file
        config_path = sys.argv[1]
        if validate_config(config_path):
            sys.exit(0)
        else:
            sys.exit(1)
    else:
        # Validate all config files in environments/
        environments_dir = Path("environments")
        if not environments_dir.exists():
            print("❌ environments/ directory not found")
            sys.exit(1)

        all_valid = True
        for env_dir in environments_dir.iterdir():
            if env_dir.is_dir():
                config_file = env_dir / "config.yaml"
                if config_file.exists():
                    if not validate_config(config_file):
                        all_valid = False

        if all_valid:
            print("✅ All configurations are valid")
            sys.exit(0)
        else:
            print("❌ Some configurations have errors")
            sys.exit(1)


if __name__ == "__main__":
    main()
