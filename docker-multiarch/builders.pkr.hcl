source "docker" "amd64" {
    image = "docker.io/amd64/alpine"
    commit = true
    platform = "linux/amd64"
}

source "docker" "arm64" {
    image = "docker.io/arm64v8/alpine"
    commit = true
    platform = "linux/arm64/v8"
}

source "docker" "arm32" {
    image = "docker.io/arm32v7/alpine"
    commit = true
    platform = "linux/arm/v7"
}

source "docker" "i386" {
    image = "docker.io/i386/alpine"
    commit = true
    platform = "linux/i386"
}

source "docker" "ppc64le" {
    image = "docker.io/ppc64le/alpine"
    commit = true
    platform = "linux/ppc64le"
}

build {
    sources = [
        "source.docker.amd64",
        "source.docker.arm64",
        "source.docker.arm32",
        "source.docker.i386",
        "source.docker.ppc64le",
    ]

    provisioner "shell" {
        inline = [
            "uname -a",
        ]
    }
    provisioner "shell" {
        inline = [
            "apk add --no-cache curl",
        ]
    }
    post-processor "docker-tag" {
        repository = "local/packerbuild"
        tag = ["${source.name}"]
    }            
}