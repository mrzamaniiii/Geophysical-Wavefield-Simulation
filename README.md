<img width="480" height="244" alt="B" src="https://github.com/user-attachments/assets/7e43adad-50ab-4b1c-84bd-751dea7a9d68" />

# Geophysical Imaging Simulations

This repository contains a collection of MATLAB simulations for modeling acoustic wave propagation in geophysical environments. Each script demonstrates different physical phenomena relevant to seismic imaging and subsurface exploration.
## Simulated Phenomena

- **Mie Scattering**: Wave attenuation due to sub-wavelength velocity perturbations.
- **Beamforming & Acoustic Lens**: Focused wavefields using source array delays and parabolic reflectors.
- **Layered Refraction**: Modeling of seismic wave bending in multi-layer media with velocity gradients.
- **Scattering & Obstacles**: Wave behavior in presence of high-speed anomalies and reflectors.

## Files

| Filename                         | Description                                                  |
|----------------------------------|--------------------------------------------------------------|
| `mie_scattering_simulation.m`    | Simulates attenuation from Mie scattering in noisy regions. |
| `beamforming_lens_model.m`       | Demonstrates focused waves using a curved high-speed lens.  |
| `layered_refraction_model.m`     | Simulates wave refraction through a multi-layered model.    |
| `scattering_with_obstacle.m`     | Shows reflection and scattering due to a velocity anomaly.  |

## Requirements

- MATLAB R2021a or later
- Custom function: `acu2Dpro`

## Sample Outputs

- Seismic traces with/without attenuation
- Focused energy at desired depth
- Reflected waves from lens and obstacles
