# Khmer Word Segmentation using Conditional Random Fields (CRF)

An open-source, high-accuracy Khmer word segmentation engine based on a 5-tag sequence labeling methodology and Conditional Random Fields (CRF). 

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![NLP](https://img.shields.io/badge/Domain-NLP%20%2F%20Computational%20Linguistics-blue)](#)

## 🌟 Key Features
- **5-Tag Tokenization Scheme:** Moving beyond simple Binary (B/I) boundaries to capture the nuances of Khmer character clusters.
- **Robust Preprocessing:** Built-in linguistic rules for handling Khmer consonants, subscripts (ជើង), vowels, and diacritics.
- **Cross-Platform:** Supports deployment and training workflows on both Linux (`.sh`) and Windows (`.bat`).

## 📖 Research Background
This implementation is based on the methodology outlined in `KhNLP2015-SEG.pdf` (included in this repository), which addresses the challenges of zero-whitespace scripts in low-resource language processing.

## 🚀 Quick Start
```bash
# Clone the repository
git clone [https://github.com/vichetchea007/vichet-khmer-word-segmentation.git](https://github.com/vichetchea007/vichet-khmer-word-segmentation.git)
cd vichet-khmer-word-segmentation

# Run the sample segmentation script (Provide a clear 1-line example command here)
./run-segmentation.sh input.txt output.txt
