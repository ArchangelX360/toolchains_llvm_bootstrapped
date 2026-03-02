# TODO: cleanup that implementation
# TODO: replace Windows transformations by vfsoverlay setup in clang calls for case-sensitiveness fix on Linux

_WINSDK_DIR = "Windows Kits"
_WINSDK_SPACELESS_DIR = _WINSDK_DIR.replace(" ", "")

_MSVC_BUILD_FILE_CONTENT = """\
load("@bazel_skylib//rules/directory:directory.bzl", "directory")
load("@bazel_skylib//rules/directory:subdirectory.bzl", "subdirectory")

package(default_visibility = ["//visibility:public"])

directory(
    name = "sysroot_files",
    srcs = glob(["__WINSYSROOT_DIR__/**"], allow_empty = True),
)

subdirectory(
    name = "sysroot_directory",
    parent = ":sysroot_files",
    path = "__WINSYSROOT_DIR__",
)

directory(
    name = "msvc_include_files",
    srcs = glob(["__WINSYSROOT_DIR__/VC/Tools/MSVC/__MSVC_VERSION__/include/**"], allow_empty = True),
)

subdirectory(
    name = "msvc_include",
    parent = ":msvc_include_files",
    path = "__WINSYSROOT_DIR__/VC/Tools/MSVC/__MSVC_VERSION__/include",
)

directory(
    name = "winsdk_ucrt_include_files",
    srcs = glob(["__WINSYSROOT_DIR__/__WINSDK_SPACELESS_DIR__/10/Include/__WINSDK_INCLUDE_VERSION__/ucrt/**"], allow_empty = True),
)

subdirectory(
    name = "winsdk_ucrt_include",
    parent = ":winsdk_ucrt_include_files",
    path = "__WINSYSROOT_DIR__/__WINSDK_SPACELESS_DIR__/10/Include/__WINSDK_INCLUDE_VERSION__/ucrt",
)

directory(
    name = "winsdk_shared_include_files",
    srcs = glob(["__WINSYSROOT_DIR__/__WINSDK_SPACELESS_DIR__/10/Include/__WINSDK_INCLUDE_VERSION__/shared/**"], allow_empty = True),
)

subdirectory(
    name = "winsdk_shared_include",
    parent = ":winsdk_shared_include_files",
    path = "__WINSYSROOT_DIR__/__WINSDK_SPACELESS_DIR__/10/Include/__WINSDK_INCLUDE_VERSION__/shared",
)

directory(
    name = "winsdk_um_include_files",
    srcs = glob(["__WINSYSROOT_DIR__/__WINSDK_SPACELESS_DIR__/10/Include/__WINSDK_INCLUDE_VERSION__/um/**"], allow_empty = True),
)

subdirectory(
    name = "winsdk_um_include",
    parent = ":winsdk_um_include_files",
    path = "__WINSYSROOT_DIR__/__WINSDK_SPACELESS_DIR__/10/Include/__WINSDK_INCLUDE_VERSION__/um",
)

directory(
    name = "winsdk_winrt_include_files",
    srcs = glob(["__WINSYSROOT_DIR__/__WINSDK_SPACELESS_DIR__/10/Include/__WINSDK_INCLUDE_VERSION__/winrt/**"], allow_empty = True),
)

subdirectory(
    name = "winsdk_winrt_include",
    parent = ":winsdk_winrt_include_files",
    path = "__WINSYSROOT_DIR__/__WINSDK_SPACELESS_DIR__/10/Include/__WINSDK_INCLUDE_VERSION__/winrt",
)

directory(
    name = "msvc_lib_arm64_files",
    srcs = glob(["__WINSYSROOT_DIR__/VC/Tools/MSVC/__MSVC_VERSION__/lib/arm64/**"], allow_empty = True),
)

subdirectory(
    name = "msvc_lib_arm64",
    parent = ":msvc_lib_arm64_files",
    path = "__WINSYSROOT_DIR__/VC/Tools/MSVC/__MSVC_VERSION__/lib/arm64",
)

directory(
    name = "msvc_lib_x64_files",
    srcs = glob(["__WINSYSROOT_DIR__/VC/Tools/MSVC/__MSVC_VERSION__/lib/x64/**"], allow_empty = True),
)

subdirectory(
    name = "msvc_lib_x64",
    parent = ":msvc_lib_x64_files",
    path = "__WINSYSROOT_DIR__/VC/Tools/MSVC/__MSVC_VERSION__/lib/x64",
)

directory(
    name = "winsdk_ucrt_lib_arm64_files",
    srcs = glob(["__WINSYSROOT_DIR__/__WINSDK_SPACELESS_DIR__/10/Lib/__WINSDK_LIB_VERSION__/ucrt/arm64/**"], allow_empty = True),
)

subdirectory(
    name = "winsdk_ucrt_lib_arm64",
    parent = ":winsdk_ucrt_lib_arm64_files",
    path = "__WINSYSROOT_DIR__/__WINSDK_SPACELESS_DIR__/10/Lib/__WINSDK_LIB_VERSION__/ucrt/arm64",
)

directory(
    name = "winsdk_ucrt_lib_x64_files",
    srcs = glob(["__WINSYSROOT_DIR__/__WINSDK_SPACELESS_DIR__/10/Lib/__WINSDK_LIB_VERSION__/ucrt/x64/**"], allow_empty = True),
)

subdirectory(
    name = "winsdk_ucrt_lib_x64",
    parent = ":winsdk_ucrt_lib_x64_files",
    path = "__WINSYSROOT_DIR__/__WINSDK_SPACELESS_DIR__/10/Lib/__WINSDK_LIB_VERSION__/ucrt/x64",
)

directory(
    name = "winsdk_um_lib_arm64_files",
    srcs = glob(["__WINSYSROOT_DIR__/__WINSDK_SPACELESS_DIR__/10/Lib/__WINSDK_LIB_VERSION__/um/arm64/**"], allow_empty = True),
)

subdirectory(
    name = "winsdk_um_lib_arm64",
    parent = ":winsdk_um_lib_arm64_files",
    path = "__WINSYSROOT_DIR__/__WINSDK_SPACELESS_DIR__/10/Lib/__WINSDK_LIB_VERSION__/um/arm64",
)

directory(
    name = "winsdk_um_lib_x64_files",
    srcs = glob(["__WINSYSROOT_DIR__/__WINSDK_SPACELESS_DIR__/10/Lib/__WINSDK_LIB_VERSION__/um/x64/**"], allow_empty = True),
)

subdirectory(
    name = "winsdk_um_lib_x64",
    parent = ":winsdk_um_lib_x64_files",
    path = "__WINSYSROOT_DIR__/__WINSDK_SPACELESS_DIR__/10/Lib/__WINSDK_LIB_VERSION__/um/x64",
)

alias(
    name = "msvc_lib",
    actual = select({
        "@llvm//platforms/config:windows_aarch64": ":msvc_lib_arm64",
        "//conditions:default": ":msvc_lib_x64",
    }),
)

alias(
    name = "winsdk_ucrt_lib",
    actual = select({
        "@llvm//platforms/config:windows_aarch64": ":winsdk_ucrt_lib_arm64",
        "//conditions:default": ":winsdk_ucrt_lib_x64",
    }),
)

alias(
    name = "winsdk_um_lib",
    actual = select({
        "@llvm//platforms/config:windows_aarch64": ":winsdk_um_lib_arm64",
        "//conditions:default": ":winsdk_um_lib_x64",
    }),
)

filegroup(
    name = "all_files",
    srcs = glob(["**"], allow_empty = True),
)

filegroup(
    name = "windows_sdk",
    srcs = [":sysroot_directory"],
)

filegroup(
    name = "headers_include",
    srcs = glob([
        "**/*.h",
        "**/*.hh",
        "**/*.hpp",
    ], allow_empty = True),
)

filegroup(
    name = "libs",
    srcs = glob(["**/*.lib"], allow_empty = True),
)
"""

_MSVC_ALIASES_BUILD_FILE_CONTENT = """\
package(default_visibility = ["//visibility:public"])

alias(
    name = "all_files",
    actual = "@{target_repo}//:all_files",
)

alias(
    name = "windows_sdk",
    actual = "@{target_repo}//:windows_sdk",
)

alias(
    name = "sysroot_directory",
    actual = "@{target_repo}//:sysroot_directory",
)

alias(
    name = "headers_include",
    actual = "@{target_repo}//:headers_include",
)

alias(
    name = "msvc_include",
    actual = "@{target_repo}//:msvc_include",
)

alias(
    name = "winsdk_ucrt_include",
    actual = "@{target_repo}//:winsdk_ucrt_include",
)

alias(
    name = "winsdk_shared_include",
    actual = "@{target_repo}//:winsdk_shared_include",
)

alias(
    name = "winsdk_um_include",
    actual = "@{target_repo}//:winsdk_um_include",
)

alias(
    name = "winsdk_winrt_include",
    actual = "@{target_repo}//:winsdk_winrt_include",
)

alias(
    name = "msvc_lib",
    actual = "@{target_repo}//:msvc_lib",
)

alias(
    name = "winsdk_ucrt_lib",
    actual = "@{target_repo}//:winsdk_ucrt_lib",
)

alias(
    name = "winsdk_um_lib",
    actual = "@{target_repo}//:winsdk_um_lib",
)

alias(
    name = "libs",
    actual = "@{target_repo}//:libs",
)
"""

def _host_tokens(repository_ctx):
    os_name = repository_ctx.os.name.lower()
    arch = repository_ctx.os.arch.lower()

    if os_name.startswith("mac os"):
        os_token = "darwin"
    elif os_name.startswith("linux"):
        os_token = "linux"
    elif os_name.startswith("windows"):
        os_token = "windows"
    else:
        os_token = ""

    if arch in ["arm64", "aarch64"]:
        arch_tokens = ["arm64", "aarch64"]
    elif arch in ["x86_64", "amd64"]:
        arch_tokens = ["x86_64", "amd64"]
    else:
        arch_tokens = []

    return os_token, arch_tokens

def _default_winsysroot_urls(repository_ctx):
    os_token, arch_tokens = _host_tokens(repository_ctx)
    if not os_token or not arch_tokens:
        return []

    tag = repository_ctx.attr.winsysroot_version
    repo_base = "https://github.com/ArchangelX360/winsysroot/releases/download/{}".format(tag)
    urls = []
    for arch_token in arch_tokens:
        base_names = [
            "winsysroot-{}-{}".format(os_token, arch_token),
            "winsysroot_{}_{}".format(os_token, arch_token),
            "winsysroot-{}-{}-{}".format(tag, os_token, arch_token),
            "winsysroot_{}_{}_{}".format(tag, os_token, arch_token),
        ]
        names_with_exe = [name + ".exe" for name in base_names]
        names_without_exe = base_names
        names = names_with_exe + names_without_exe if os_token == "windows" else names_without_exe + names_with_exe
        urls.extend(["{}/{}".format(repo_base, name) for name in names])
    return urls

def _normalize_relpath(path):
    return path.replace("\\", "/")

def _lowercase_basename(path):
    idx = path.rfind("/")
    if idx == -1:
        return path.lower()
    return path[:idx + 1] + path[idx + 1:].lower()

def _match_glob_pattern(path, pattern):
    if pattern.startswith("**/*."):
        return path.endswith(pattern[len("**/*"):])
    return path == pattern

def _collect_files_recursive(path, files):
    if not path.is_dir:
        files.append(path)
        return

    pending_dirs = [path]
    for _ in range(64):
        if not pending_dirs:
            return
        next_dirs = []
        for current_dir in pending_dirs:
            for entry in current_dir.readdir():
                if entry.is_dir:
                    next_dirs.append(entry)
                else:
                    files.append(entry)
        pending_dirs = next_dirs

    if pending_dirs:
        fail("windows sysroot traversal exceeded depth limit (64)")

def _relative_to_repo_root(repository_ctx, path):
    repo_root = str(repository_ctx.path("."))
    abs_path = str(path)
    if abs_path.startswith(repo_root + "/"):
        return _normalize_relpath(abs_path[len(repo_root) + 1:])
    if abs_path.startswith(repo_root + "\\"):
        return _normalize_relpath(abs_path[len(repo_root) + 1:])
    return _normalize_relpath(abs_path)

def _apply_windows_sysroot_transformations(repository_ctx, winsysroot_dir):
    transformations = repository_ctx.attr.windows_sysroot_transformations
    if not transformations:
        return

    sysroot = repository_ctx.path(winsysroot_dir)
    if not sysroot.exists:
        return

    all_files = []
    _collect_files_recursive(sysroot, all_files)
    all_rel_files = [_relative_to_repo_root(repository_ctx, f) for f in all_files]

    created = {}

    for src_pattern, transform in transformations.items():
        src_pattern = _normalize_relpath(src_pattern)
        if transform != "lowercase":
            transform = _normalize_relpath(transform)

        for src_rel in all_rel_files:
            matches = False
            dst_rel = ""

            if transform == "lowercase":
                matches = _match_glob_pattern(src_rel, src_pattern)
                if matches:
                    dst_rel = _lowercase_basename(src_rel)
            elif src_rel == src_pattern or src_rel.endswith("/" + src_pattern):
                matches = True
                dst_rel = src_rel[:len(src_rel) - len(src_pattern)] + transform

            if not matches or not dst_rel or dst_rel == src_rel:
                continue
            if dst_rel in created:
                continue

            dst_path = repository_ctx.path(dst_rel)
            if dst_path.exists:
                continue

            repository_ctx.symlink(src_rel, dst_rel)
            created[dst_rel] = src_rel

def _winsysroot_alias_repository_impl(repository_ctx):
    repository_ctx.file(
        "BUILD.bazel",
        _MSVC_ALIASES_BUILD_FILE_CONTENT.format(
            target_repo = repository_ctx.attr.target_repo,
        ),
    )

_winsysroot_alias_repository = repository_rule(
    implementation = _winsysroot_alias_repository_impl,
    attrs = {
        "target_repo": attr.string(mandatory = True),
    },
)

def _download_file(repository_ctx, urls, output, sha256 = "", integrity = "", executable = False):
    kwargs = {
        "url": urls,
        "output": output,
    }
    if executable:
        kwargs["executable"] = True
    if integrity:
        kwargs["integrity"] = integrity
    elif sha256:
        kwargs["sha256"] = sha256
    repository_ctx.download(**kwargs)

def _channel_manifest_urls(repository_ctx):
    if repository_ctx.attr.visual_studio_channel_urls:
        return repository_ctx.attr.visual_studio_channel_urls
    return ["https://aka.ms/vs/{}/release/channel".format(repository_ctx.attr.visual_studio_release)]

def _download_installer_manifest(repository_ctx):
    installer_manifest_path = "winsysroot_manifests/installer_manifest.json"
    if repository_ctx.attr.installer_manifest_urls:
        _download_file(
            repository_ctx,
            repository_ctx.attr.installer_manifest_urls,
            installer_manifest_path,
        )
        return installer_manifest_path

    channel_manifest_path = "winsysroot_manifests/channel_manifest.json"
    _download_file(
        repository_ctx,
        _channel_manifest_urls(repository_ctx),
        channel_manifest_path,
    )
    channel_manifest = json.decode(repository_ctx.read(channel_manifest_path))
    for item in channel_manifest.get("channelItems", []):
        if item.get("id", "") != "Microsoft.VisualStudio.Manifests.VisualStudio":
            continue
        payloads = item.get("payloads", [])
        if not payloads:
            fail("channel manifest entry Microsoft.VisualStudio.Manifests.VisualStudio has no payloads")
        installer_manifest_url = payloads[0].get("url", "")
        if not installer_manifest_url:
            fail("channel manifest entry Microsoft.VisualStudio.Manifests.VisualStudio has no payload url")

        # TODO: make parallel
        _download_file(
            repository_ctx,
            [installer_manifest_url],
            installer_manifest_path,
        )
        return installer_manifest_path
    fail("failed to find installer manifest URL in Visual Studio channel manifest")

def _normalize_payload_path(path):
    return path.replace("\\", "/")

def _select_windows_sdk_package(installer_manifest, windows_sdk_version):
    suffix = "SDK_" + windows_sdk_version
    for pkg in installer_manifest.get("packages", []):
        pkg_id = pkg.get("id", "")
        if pkg_id.startswith("Win") and pkg_id.endswith(suffix):
            return pkg
    fail("failed to find Windows SDK package for version {}".format(windows_sdk_version))

def _download_windows_sdk_msis(repository_ctx, installer_manifest):
    sdk_pkg = _select_windows_sdk_package(installer_manifest, repository_ctx.attr.windows_sdk_version)
    for payload in sdk_pkg.get("payloads", []):
        file_name = _normalize_payload_path(payload.get("fileName", ""))
        if not file_name.lower().endswith(".msi"):
            continue
        _download_file(
            repository_ctx,
            [payload["url"]],
            "winsysroot_msis/{}".format(file_name),
            sha256 = payload.get("sha256", ""),
        )

def _run_winsysroot_plan(repository_ctx, winsysroot_path, installer_manifest_path):
    plan_path = "winsysroot_download_plan.json"
    plan_cmd = [
        str(winsysroot_path),
        "plan",
        "--installer-manifest",
        installer_manifest_path,
        "--winsdk-msi-dir",
        "winsysroot_msis",
        "--out-manifest",
        plan_path,
        "--win-sdk-version",
        repository_ctx.attr.windows_sdk_version,
        "--architectures",
        repository_ctx.attr.architectures,
        "--slim={}".format("true" if repository_ctx.attr.slim else "false"),
    ]
    result = repository_ctx.execute(plan_cmd)
    if result.return_code != 0:
        fail("winsysroot plan failed with exit code {}.\nstdout:\n{}\nstderr:\n{}".format(result.return_code, result.stdout, result.stderr))
    return plan_path

def _download_winsysroot_plan_artifacts(repository_ctx, plan_path):
    plan = json.decode(repository_ctx.read(plan_path))
    downloads = plan.get("downloads", [])
    if type(downloads) != type([]):
        fail("winsysroot plan at {} is missing a valid downloads list".format(plan_path))

    for index, download in enumerate(downloads):
        urls = download.get("urls", [])
        if not urls:
            url = download.get("url", "")
            if url:
                urls = [url]
        if not urls:
            fail("winsysroot plan download entry {} has no url/urls".format(index))

        output_name = download.get("name", "download_{}".format(index))

        # TODO: make parallel
        _download_file(
            repository_ctx,
            urls,
            "winsysroot_downloads/{}".format(output_name),
            sha256 = download.get("sha256", ""),
            integrity = download.get("integrity", ""),
        )

def _collect_versions(field_value, field_name):
    if type(field_value) != type([]):
        fail("winsysroot metadata.{} must be a list".format(field_name))

    versions = []
    seen = {}
    for value in field_value:
        if type(value) != type(""):
            fail("winsysroot metadata.{} must contain strings".format(field_name))
        if not value or seen.get(value, False):
            continue
        seen[value] = True
        versions.append(value)
    return versions

def _select_windows_sdk_version(versions, attr_version, field_name):
    preferred = attr_version + ".0"
    if preferred in versions:
        return preferred
    if attr_version in versions:
        return attr_version
    if len(versions) == 1:
        return versions[0]
    if not versions:
        fail("winsysroot metadata.{} is empty".format(field_name))
    fail("unable to choose {} from {} using requested windows_sdk_version {}".format(field_name, versions, attr_version))

def _resolve_winsysroot_versions(repository_ctx, metadata):
    if type(metadata) != type({}):
        fail("winsysroot metadata file is missing a valid JSON object")

    msvc_versions = _collect_versions(metadata.get("msvc_versions", []), "msvc_versions")
    if len(msvc_versions) != 1:
        fail("expected exactly one MSVC version in metadata, got {}".format(msvc_versions))

    include_versions = _collect_versions(metadata.get("windows_sdk_include_versions", []), "windows_sdk_include_versions")
    lib_versions = _collect_versions(metadata.get("windows_sdk_lib_versions", []), "windows_sdk_lib_versions")

    return {
        "msvc_version": msvc_versions[0],
        "windows_sdk_include_version": _select_windows_sdk_version(include_versions, repository_ctx.attr.windows_sdk_version, "windows_sdk_include_versions"),
        "windows_sdk_lib_version": _select_windows_sdk_version(lib_versions, repository_ctx.attr.windows_sdk_version, "windows_sdk_lib_versions"),
    }

def _assemble_winsysroot_from_plan(repository_ctx, winsysroot_path, plan_path, winsysroot_dir):
    metadata_path = "winsysroot_versions.json"
    assemble_cmd = [
        str(winsysroot_path),
        "assemble",
        "--in-manifest",
        plan_path,
        "--winsdk-msi-dir",
        "winsysroot_msis",
        "--downloads-dir",
        "winsysroot_downloads",
        "--out-dir",
        winsysroot_dir,
        "--with-spaceless-aliases",  # Otherwise, `/imsvc` inclusion do not work in some cc compilation like cargo build script's `cc-rs`
        "--out-metadata",
        metadata_path,
    ]
    result = repository_ctx.execute(assemble_cmd)
    if result.return_code != 0:
        fail("winsysroot assemble failed with exit code {}.\nstdout:\n{}\nstderr:\n{}".format(result.return_code, result.stdout, result.stderr))
    metadata = json.decode(repository_ctx.read(metadata_path))
    return _resolve_winsysroot_versions(repository_ctx, metadata)

def _winsysroot_v2_repository_impl(repository_ctx):
    winsysroot_path = repository_ctx.which("winsysroot")
    winsysroot_dir = "sysroot"

    default_urls = []
    if not repository_ctx.attr.winsysroot_urls and not winsysroot_path:
        default_urls = _default_winsysroot_urls(repository_ctx)

    winsysroot_urls = repository_ctx.attr.winsysroot_urls if repository_ctx.attr.winsysroot_urls else default_urls
    if winsysroot_urls:
        os_token, _ = _host_tokens(repository_ctx)
        binary_name = "winsysroot.exe" if os_token == "windows" else "winsysroot"
        winsysroot_path = repository_ctx.path(binary_name)
        _download_file(
            repository_ctx,
            winsysroot_urls,
            winsysroot_path,
            sha256 = repository_ctx.attr.winsysroot_sha256,
            integrity = repository_ctx.attr.winsysroot_integrity,
            executable = True,
        )

    if not winsysroot_path:
        fail("winsysroot is required. Provide msvc2.winsysroot(urls = [...]) or install a `winsysroot` binary in PATH.")

    installer_manifest_path = _download_installer_manifest(repository_ctx)
    installer_manifest = json.decode(repository_ctx.read(installer_manifest_path))
    _download_windows_sdk_msis(repository_ctx, installer_manifest)

    plan_path = _run_winsysroot_plan(repository_ctx, winsysroot_path, installer_manifest_path)
    _download_winsysroot_plan_artifacts(repository_ctx, plan_path)
    versions = _assemble_winsysroot_from_plan(repository_ctx, winsysroot_path, plan_path, winsysroot_dir)

    _apply_windows_sysroot_transformations(repository_ctx, winsysroot_dir)

    build_file_content = _MSVC_BUILD_FILE_CONTENT
    build_file_content = build_file_content.replace("__WINSYSROOT_DIR__", winsysroot_dir)
    build_file_content = build_file_content.replace("__WINSDK_SPACELESS_DIR__", _WINSDK_SPACELESS_DIR)
    build_file_content = build_file_content.replace("__MSVC_VERSION__", versions["msvc_version"])
    build_file_content = build_file_content.replace("__WINSDK_INCLUDE_VERSION__", versions["windows_sdk_include_version"])
    build_file_content = build_file_content.replace("__WINSDK_LIB_VERSION__", versions["windows_sdk_lib_version"])
    repository_ctx.file("BUILD.bazel", build_file_content)

_winsysroot_v2_repository = repository_rule(
    implementation = _winsysroot_v2_repository_impl,
    attrs = {
        "winsysroot_urls": attr.string_list(),
        "winsysroot_sha256": attr.string(),
        "winsysroot_integrity": attr.string(),
        "winsysroot_version": attr.string(),
        "visual_studio_release": attr.string(),
        "visual_studio_channel_urls": attr.string_list(),
        "installer_manifest_urls": attr.string_list(),
        "windows_sdk_version": attr.string(),
        "architectures": attr.string(),
        "slim": attr.bool(),
        "windows_sysroot_transformations": attr.string_dict(),
    },
)

def _read_winsysroot_tag(module_ctx):
    root_tags = []
    non_root_tags = []
    for mod in module_ctx.modules:
        if mod.is_root:
            root_tags.extend(mod.tags.winsysroot)
        else:
            non_root_tags.extend(mod.tags.winsysroot)

    if len(root_tags) > 1:
        fail("Only one msvc2.winsysroot(...) tag is supported in the root module.")

    if root_tags:
        return root_tags[0]
    if non_root_tags:
        return non_root_tags[0]
    return None

def _msvc2_extension_impl(module_ctx):
    winsysroot_tag = _read_winsysroot_tag(module_ctx)
    if not winsysroot_tag:
        fail("must specify msvc2.winsysroot() extension")

    _winsysroot_v2_repository(
        name = "windows_sdk",
        winsysroot_urls = winsysroot_tag.urls,
        winsysroot_sha256 = winsysroot_tag.sha256,
        winsysroot_integrity = winsysroot_tag.integrity,
        winsysroot_version = winsysroot_tag.version,
        visual_studio_release = winsysroot_tag.visual_studio_release,
        visual_studio_channel_urls = winsysroot_tag.visual_studio_channel_urls,
        installer_manifest_urls = winsysroot_tag.installer_manifest_urls,
        windows_sdk_version = winsysroot_tag.windows_sdk_version,
        architectures = winsysroot_tag.architectures,
        slim = winsysroot_tag.slim,
        windows_sysroot_transformations = winsysroot_tag.windows_sysroot_transformations,
    )

    _winsysroot_alias_repository(
        name = "windows_sdk_arm64",
        target_repo = "windows_sdk",
    )
    _winsysroot_alias_repository(
        name = "windows_sdk_x64",
        target_repo = "windows_sdk",
    )

    return module_ctx.extension_metadata(
        root_module_direct_deps = ["windows_sdk", "windows_sdk_arm64", "windows_sdk_x64"],
        root_module_direct_dev_deps = [],
    )

_winsysroot = tag_class(
    attrs = {
        "urls": attr.string_list(
            doc = "Optional prebuilt winsysroot binary URLs. If not set, URLs are auto-derived from `version` when no local winsysroot binary is available in PATH.",
        ),
        "version": attr.string(
            default = "master-092d797c9fa08006c45ca390ca52f342af5fc464",
            doc = "winsysroot release tag used to derive default binary URLs.",
        ),
        "sha256": attr.string(
            doc = "Optional SHA-256 for the downloaded winsysroot binary.",
        ),
        "integrity": attr.string(
            doc = "Optional SRI integrity for the downloaded winsysroot binary.",
        ),
        "visual_studio_release": attr.string(
            default = "17",
            doc = "Visual Studio release channel used to resolve the installer manifest.",
        ),
        "visual_studio_channel_urls": attr.string_list(
            doc = "Optional override URLs for the Visual Studio channel manifest.",
        ),
        "installer_manifest_urls": attr.string_list(
            doc = "Optional override URLs for the Visual Studio installer manifest. If set, the channel manifest download is skipped.",
        ),
        "windows_sdk_version": attr.string(
            default = "10.0.26100",
            doc = "Windows SDK version requested from the installer manifest.",
        ),
        "architectures": attr.string(
            default = "x64,arm64",
            doc = "Comma-separated architectures forwarded to winsysroot.",
        ),
        "slim": attr.bool(
            default = True,
            doc = "Whether to request winsysroot's slim extraction mode.",
        ),
        "windows_sysroot_transformations": attr.string_dict(
            default = {},
            doc = "Map of source path patterns to transformations. Supports exact paths and `**/*.ext` patterns. Use value `lowercase` to create lowercase aliases.",
        ),
    },
)

msvc = module_extension(
    implementation = _msvc2_extension_impl,
    tag_classes = {
        "winsysroot": _winsysroot,
    },
    doc = "Offline winsysroot extension that delegates all downloads to Bazel.",
)
