#!/usr/bin/env python3
"""压缩图片到 500KB 以下"""
import os
from PIL import Image

IMG_DIR = "/Users/dongbin/blog/static/images/murphy"
MAX_SIZE = 500 * 1024  # 500KB
QUALITY = 85

for filename in os.listdir(IMG_DIR):
    if not filename.lower().endswith(('.jpg', '.jpeg', '.png')):
        continue
    
    filepath = os.path.join(IMG_DIR, filename)
    file_size = os.path.getsize(filepath)
    
    if file_size <= MAX_SIZE:
        print(f"✓ {filename}: {file_size/1024:.1f}KB (无需压缩)")
        continue
    
    print(f"压缩：{filename} ({file_size/1024:.1f}KB)", end="")
    
    # 打开并压缩
    img = Image.open(filepath)
    
    # 调整尺寸
    max_dim = 1200
    if max(img.size) > max_dim:
        ratio = max_dim / max(img.size)
        new_size = (int(img.size[0] * ratio), int(img.size[1] * ratio))
        img = img.resize(new_size, Image.Resampling.LANCZOS)
    
    # 保存为 JPEG
    if filename.lower().endswith('.png'):
        filename = filename[:-4] + '.jpg'
        filepath = os.path.join(IMG_DIR, filename)
    
    img.save(filepath, 'JPEG', quality=QUALITY, optimize=True)
    new_size = os.path.getsize(filepath)
    print(f" → {new_size/1024:.1f}KB")

print("\n压缩完成！")
