// Source fingerprint MW-WMA-2026-8d573e4b | Copyright (c) 2026 Michael Wiedeck. All rights reserved.
import 'dart:convert';
import 'package:flutter/material.dart';

// Compact preview of approved WM04b artwork. Native high-resolution launcher
// icons are generated separately from the original logo-set in Google Drive.
const wm04bPreviewBase64 = 'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAMAAACdt4HsAAAASFBMVEX+91b+7wP/+AH94wH06ovkwsqs3aBr6b3PnuaaknRqUmNaEoxDEmckFDE/B2woB0gfBzkbBzEcBTYXByoTByIUAy4MAiIJAxS7WN+7AAAE2klEQVR42pWYi3KkIBBFVSaJMPQo7///073d+AB1q5KurYwC99AvmXGHr8PmeX7/yrDwVA2H/P03m3vAX+VsLeC/iz5Gm+5+t8OJ4b49pq2VVfZjx2kyn+3OflrbCEO7fzNtWWU/Zhx3QC+vjFkAD2oNkbXigQDYPlrfGG8GzJ9eDVPVb2sXASysX/Q0qeWKMAC8r1i7qGkczcJWAWxmGictV0sXxDDfIsMSxbux0QFQ4zbUQ+bBNGnDv+XYTpbTNFUAO0XLckO8h6NgEuhmq5mUCFc9avkA0fhluSMGu3w+rbaaR8pEudIK85xWvy7LHTEsTwaN1rTi03vPBNJGPu+I4T96L7YSG1+ltFb7DUAWek9GKzWOSiltKPnVr0+M4Vm+JqOHAQ/CZkpTcv5ANIyhu93nPUEOADaHF0oQpnXi1AzrgyX7Yr0mSmxk0EXoQ+cfnHgCJPN6vQbEnRzrnUuZFLeW874hVMYDwFvoX4jZ5cRFcAKS5kzO9wwAvO/GOE7Iv11aM8rw4li0ASLL0QDqhbADeLB+JKhejhXsiCQD2UiUDT8OIHReAOCqec4QbhJBgHVJf7Fea6nHQBkjEwfhXOvFCdgtQaCzy6z/NiEjD0YIKZDaXGgRw1WPVYqS+K9zDimFkNkpnQKCmHRyJ4EZNwByBT/TN/QFyScKSAcTDHzBXLNWCHeAQs9lggMhJOI+NJxQjisE8a4j7IBwpkBJBJsAiYfbuOIshDrpQjgJAIRqrl6wBwBodhkxI21AUObUMpcnwwlwDWAz5NxQyBq+5oyDTABg8QDaEZMdwPkrIKB3kXfORM7qAETFeyeZDIfPD4BcSkaQeHgACDuA+J4zEVLOObYMP3TyaI2xjlfiWzmSZGDkaHA4UeaO4CByI3EtoFj+7THP2BupwLabAyoShCHEYH7YdINoAcWwmg3eZqpPjwAyCJRi+NntJDSAzPtb50jDhxJibIoQKeZQNG8OZ0CIDUCuY8T81xwLGwgR1haBb+nnx8i8xUVuAJsF3hhniC0ETwpGziIwoWBnRKaNgytwsQGEHWADZ4GiAOQclBTA7VwBvPmPxtWTB/H9Tgb6L5MAYcC45RAgPNkFIXAakEI6AaEBrAtHz1V8vxHyXgQgOA8xR2Oy1NFkEtUVEANJESktOIhMPAC1m5AgqgBddhEDTn1GI7DlWkLqAZMUg6QNYskH4QCUbKlGgALw4WVUB5B+iqX2EdGO2AElVPW8FWDLXQ9AGorZetGgtRqAPAWb5RIlf2ocLwAUs9DP2c8iFUChU6+NKfmy+eFBMQ1AlxNgGgA3wTMgcwC6cSEfgLkz+wTAr7ZcGjXnoXAOpKQ94NmDkfKRwhYAP/IFgJB6gOJfKarEB0Ac+LnrQ0ASSfVqBmB5jjcADfy36BYQsJWu3wjqsFGVEi8uUMEpNMyXKtROjKoRC4CkaKUDoC/0gJyHDlA7iy4AOFBkvANkws/9mVu3rSGvg1M9AQ5UF0ybgoIXDvH5bEVTl2G7iwPx6kKVMWBeEAQdPcA73QCm1PP2LCWPoPz8zlRVNQ+6LuQ/lwjKDqCtApGPb3lr2wIv/L1G+04ANnp9jPIEL+P99TxvL54IPZZz79+Zre/gw/bePptQ/mJWb6/w59s7TgKi+AsLZM35HwD/ACd7yeEEKhvnAAAAAElFTkSuQmCC';

class Wm04bIcon extends StatelessWidget {
  const Wm04bIcon({super.key, this.size = 52});
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size * .22),
      child: Image.memory(
        base64Decode(wm04bPreviewBase64),
        width: size,
        height: size,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.medium,
        gaplessPlayback: true,
      ),
    );
  }
}
