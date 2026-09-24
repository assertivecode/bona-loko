import os
from PIL import Image, ImageDraw

def generate_icons():
    base_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    logo_path = os.path.join(base_dir, 'assets', 'images', 'logo.png')
    res_dir = os.path.join(base_dir, 'android', 'app', 'src', 'main', 'res')

    print(f"Reading master logo from: {logo_path}")
    im = Image.open(logo_path).convert('RGBA')

    # 1. Standard icon densities (width x height)
    densities = {
        'mipmap-mdpi': 48,
        'mipmap-hdpi': 72,
        'mipmap-xhdpi': 96,
        'mipmap-xxhdpi': 144,
        'mipmap-xxxhdpi': 192,
    }

    # 2. Adaptive icon foreground dimensions (108dp base)
    # mdpi: 108px, hdpi: 162px, xhdpi: 216px, xxhdpi: 324px, xxxhdpi: 432px
    adaptive_foreground_sizes = {
        'mipmap-mdpi': 108,
        'mipmap-hdpi': 162,
        'mipmap-xhdpi': 216,
        'mipmap-xxhdpi': 324,
        'mipmap-xxxhdpi': 432,
    }

    for folder, size in densities.items():
        target_folder = os.path.join(res_dir, folder)
        os.makedirs(target_folder, exist_ok=True)

        # Standard icon
        std_icon = im.resize((size, size), Image.Resampling.LANCZOS)
        std_icon.save(os.path.join(target_folder, 'ic_launcher.png'), 'PNG')

        # Round icon with smooth circular mask
        mask = Image.new('L', (size * 4, size * 4), 0)
        draw = ImageDraw.Draw(mask)
        draw.ellipse((0, 0, size * 4 - 1, size * 4 - 1), fill=255)
        mask = mask.resize((size, size), Image.Resampling.LANCZOS)

        round_icon = Image.new('RGBA', (size, size), (0, 0, 0, 0))
        round_icon.paste(std_icon, (0, 0))
        round_icon.putalpha(mask)
        round_icon.save(os.path.join(target_folder, 'ic_launcher_round.png'), 'PNG')

        # Foreground for adaptive icon (66% safe zone centered in 108dp canvas)
        fg_canvas_size = adaptive_foreground_sizes[folder]
        # Logo inside foreground takes ~66% safe zone: (72 / 108) * fg_canvas_size
        logo_inner_size = int(round(fg_canvas_size * (72.0 / 108.0)))
        logo_resized = im.resize((logo_inner_size, logo_inner_size), Image.Resampling.LANCZOS)

        offset = (fg_canvas_size - logo_inner_size) // 2
        fg_image = Image.new('RGBA', (fg_canvas_size, fg_canvas_size), (0, 0, 0, 0))
        fg_image.paste(logo_resized, (offset, offset), logo_resized)
        fg_image.save(os.path.join(target_folder, 'ic_launcher_foreground.png'), 'PNG')

        print(f"Generated {folder}: ic_launcher ({size}x{size}), ic_launcher_round ({size}x{size}), ic_launcher_foreground ({fg_canvas_size}x{fg_canvas_size})")

    # 3. Create values/colors.xml for adaptive icon background
    values_dir = os.path.join(res_dir, 'values')
    os.makedirs(values_dir, exist_ok=True)
    colors_xml_path = os.path.join(values_dir, 'colors.xml')
    with open(colors_xml_path, 'w', encoding='utf-8') as f:
        f.write('''<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="ic_launcher_background">#FCFBF7</color>
</resources>
''')
    print("Wrote values/colors.xml")

    # 4. Create mipmap-anydpi-v26 adaptive icon XMLs
    anydpi_dir = os.path.join(res_dir, 'mipmap-anydpi-v26')
    os.makedirs(anydpi_dir, exist_ok=True)

    adaptive_xml = '''<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@color/ic_launcher_background"/>
    <foreground android:drawable="@mipmap/ic_launcher_foreground"/>
</adaptive-icon>
'''
    with open(os.path.join(anydpi_dir, 'ic_launcher.xml'), 'w', encoding='utf-8') as f:
        f.write(adaptive_xml)

    with open(os.path.join(anydpi_dir, 'ic_launcher_round.xml'), 'w', encoding='utf-8') as f:
        f.write(adaptive_xml)

    print("Wrote mipmap-anydpi-v26/ic_launcher.xml and ic_launcher_round.xml")
    print("All Android launcher icons successfully created!")

if __name__ == '__main__':
    generate_icons()
