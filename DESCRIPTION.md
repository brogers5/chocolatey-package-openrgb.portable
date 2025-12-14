## OpenRGB

One of the biggest complaints about RGB is the software ecosystem surrounding it. Every manufacturer has their own app, their own brand, their own style. If you want to mix and match devices, you end up with a ton of conflicting, functionally identical apps competing for your background resources. On top of that, these apps are proprietary and Windows-only. Some even require online accounts. What if there was a way to control all of your RGB devices from a single app, on both Windows and Linux, without any nonsense? That is what OpenRGB sets out to achieve. One app to rule them all.

![OpenRGB Screenshot](https://cdn.jsdelivr.net/gh/brogers5/chocolatey-package-openrgb.portable@c6510c3eb4b5fe67f46449147e3da5738e6851e4/Screenshot.png)

### Features

* Set colors and select effect modes for a wide variety of RGB hardware
* Save and load profiles
* Control lighting from third party software using the OpenRGB SDK
* Command line interface
* Connect multiple instances of OpenRGB to synchronize lighting across multiple PCs
* Can operate standalone or in a client/headless server configuration
* View device information
* No official/manufacturer software required
* Graphical view of device LEDs makes creating custom patterns easy

## Package Parameters

* `/NoShim` - Opt out of creating a GUI shim.
* `/NoDesktopShortcut` - Opt out of creating a Desktop shortcut.
* `/NoProgramsShortcut` - Opt out of creating a Programs shortcut in your Start Menu.
* `/DontCheckForPawnIO` - By default, the package installation will check if [PawnIO](https://community.chocolatey.org/packages/pawnio) is installed on your system, and prompt you to install it if it is missing. If your configuration is either incompatible or does not require PawnIO, pass this to skip over the check.
* `/CreateAdminShortcuts` - OpenRGB should be run as Administrator in order for configurations that depend on PawnIO to work correctly. Pass this to ensure OpenRGB's shortcuts are created accordingly.
* `/CreateAndStartService` - If you'd prefer to run OpenRGB unelevated, PawnIO-dependent functionality will require running a separate instance of OpenRGB as a service application. Pass this to create the required service (if needed) and start it.
* `/Start` - Automatically start OpenRGB after installation completes.

## Package Notes

This package may create a [shim](https://docs.chocolatey.org/en-us/features/shim) for `OpenRGB.exe`, as is typical for a portable application package. However, `shimgen` will create a GUI shim, which will not wait for the underlying process to exit by default. This may cause issues with displaying console output when using the command-line interface. Users requiring this functionality should pass the `--shimgen-waitforexit` switch to ensure the shim behaves correctly.

---

When using the `/Start` package parameter, you may see a large `CLIXML` block logged to `stderr`. This is [a known issue](https://github.com/chocolatey/choco/issues/1016) with Chocolatey's `Start-ChocolateyProcessAsAdmin` cmdlet, and is not necessarily indicative of an error condition. Until this is addressed, you should ensure the `failOnStandardError` feature is disabled while installing/upgrading this package.

---

For future upgrade operations, consider opting into Chocolatey's `useRememberedArgumentsForUpgrades` feature to avoid having to pass the same arguments with each upgrade:

```shell
choco feature enable --name="'useRememberedArgumentsForUpgrades'"
```
