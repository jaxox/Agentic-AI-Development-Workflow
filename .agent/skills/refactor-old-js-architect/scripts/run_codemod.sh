#!/bin/bash

# run_codemod.sh
# Wrapper for jscodeshift/lebab to apply safe transformations
# Usage: ./run_codemod.sh <file> <transform_type>

FILE=$1
TRANSFORM=$2

if [ -z "$FILE" ]; then
    echo "Usage: $0 <file> [transform]"
    echo "Transforms: let (var->let/const), arrow (function->arrow), template (concat->template string)"
    exit 1
fi

if ! command -v npx &> /dev/null; then
    echo "Error: npx is not installed."
    exit 1
fi

echo "Applying transform '$TRANSFORM' to $FILE..."

# Using lebab for specific ES5->ES6 transforms
case $TRANSFORM in
    let)
        npx lebab "$FILE" -o "$FILE" --transform let
        ;;
    arrow)
        npx lebab "$FILE" -o "$FILE" --transform arrow
        ;;
    template)
        npx lebab "$FILE" -o "$FILE" --transform template
        ;;
    all)
        npx lebab "$FILE" -o "$FILE" --transform let,arrow,template,includes
        ;;
    *)
        echo "Unknown transform. Defaulting to 'safe' set (let, arrow, template)."
        npx lebab "$FILE" -o "$FILE" --transform let,arrow,template
        ;;
esac

echo "Transform complete. Please verify changes with 'npm test'."
