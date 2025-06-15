
# Proyecto de Pruebas Automatizadas - SauceDemo

Este repositorio contiene pruebas automatizadas para la página [SauceDemo](https://www.saucedemo.com/) utilizando Ruby, Cucumber, Capybara y Selenium WebDriver.

---

## Estructura del Proyecto

```
CALIDAD-PRACTICA-AUTOMATIZACION/
│
├── features/
│   ├── cart.feature
│   ├── checkout.feature
│   ├── login.feature
│   ├── saucedemo.feature
│   ├── step_definitions/
│   │   ├── cartSteps.rb
│   │   ├── checkoutSteps.rb
│   │   ├── commonSteps.rb
│   │   ├── loginSteps.rb
│   │   └── saucedemo_steps.rb
│   └── support/
│       └── env.rb
└── README.md
```

---

## Requisitos Previos

Antes de ejecutar las pruebas, asegúrate de tener instalado:

- Ruby >= 2.7
- Cucumber (`gem install cucumber`)
- Capybara (`gem install capybara`)
- Selenium WebDriver (`gem install selenium-webdriver`)
- Selenium (`gem install selenium`)
- rspec (`gem install rspec`)
- Google Chrome
- ChromeDriver (compatible con tu versión de Chrome)
- Asegúrate de tener `chromedriver` en tu `PATH`.
- Puedes modificar las pruebas o crear nuevas en el directorio `features/`.
- Para verificar las gemas de ruby que tengas instaladas puedes ejecutar `gem list`
---

## Instalación

1. Clona este repositorio:

```bash
git clone https://github.com/LuchoAMT/Calidad-Practica-Automatizacion
```

---

## Ejecución de las Pruebas

Para ejecutar **todas las pruebas**:

```bash
cucumber
```

Para ejecutar un archivo específico:

```bash
cucumber features/login.feature
```
esto ejecutará solamente las pruebas descritas en el feature file `login.feature` cambialo según la necesidad que tengas.


Para ejecutar por tag (por ejemplo, escenarios con `@smoke`):

```bash
cucumber --tags @smoke
```

Si esto no funcionara puedes ejecutar

```bash
cucumber --tags=@smoke
```

---

## Variables de Entorno

Las credenciales usadas por defecto se configuran automáticamente en el archivo `support/env.rb`:

```ruby
ENV['USER'] = "standard_user"
ENV['PASS'] = "secret_sauce"
```

---

