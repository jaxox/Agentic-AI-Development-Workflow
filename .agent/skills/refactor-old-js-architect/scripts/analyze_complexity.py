#!/usr/bin/env python3
import sys
import re

def calculate_complexity(file_path):
    """
    Heuristic-based Cyclomatic Complexity calculator for JavaScript.
    Counts branching keywords.
    """
    complexity = 1
    branching_keywords = [
        r'\bif\b', r'\belse\s+if\b', r'\bfor\b', r'\bwhile\b', 
        r'\bcase\b', r'\bcatch\b', r'\b\?\b', r'\b\|\|\b', r'\b&&\b'
    ]
    
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
            
        # Remove comments to avoid false positives
        content = re.sub(r'//.*', '', content)
        content = re.sub(r'/\*[\s\S]*?\*/', '', content)
        
        for keyword in branching_keywords:
            matches = re.findall(keyword, content)
            complexity += len(matches)
            
        print(f"File: {file_path}")
        print(f"Estimated Cyclomatic Complexity: {complexity}")
        
        if complexity > 10:
            print("WARNING: High complexity detected (>10). Consider decomposing monolithic functions.")
        else:
            print("Complexity is within acceptable limits.")
            
        return complexity
        
    except Exception as e:
        print(f"Error analyzing file: {e}")
        sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: analyze_complexity.py <js_file>")
        sys.exit(1)
        
    calculate_complexity(sys.argv[1])
