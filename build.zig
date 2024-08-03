const std = @import("std");

pub fn build(b: *std.Build) void {
    //const target = b.standardTargetOptions(.{});
    const target = std.zig.CrossTarget{ .os_tag = .freestanding, .cpu_arch = .x86 };

    const optimize = b.standardOptimizeOption(.{});

    const kmain = b.addExecutable(.{
        .name = "ostest",
        .root_source_file = b.path("src/main.zig"),
        .target = b.resolveTargetQuery(target),
        .optimize = optimize,
    });

    //    const entry = b.addAssembly(.{ .name = "ostest", .source_file = b.path("src/boot.s"), .target = b.resolveTargetQuery(target), .optimize = optimize, });

    kmain.addAssemblyFile(b.path("src/boot.s"));
    kmain.setLinkerScript(b.path("src/linker.ld"));
    b.installArtifact(kmain);

    const run_cmd = b.addRunArtifact(kmain);

    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
