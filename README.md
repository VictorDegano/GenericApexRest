# GenericApexRest

La intencion del repositorio es brindar un punto unico de entrada a los distintos servicios REST personalizados. Brinda la posibilidad de poder parametrizar los servicios REST a traves de  distintos registros de Metadatos y la posibilidad de gestionar el acceso a los mismos en base a una Configuracion Personalizada, brindando flexibilidad, seguridad y escalabilidad a la hora de exponer servicios.

Diagrama de flujo
```mermaid
flowchart TD;
    A[Inicio] --> B[Recibir Solicitud HTTP];
    B --> C{Método HTTP};
    C -->|GET| D[doGet];
    C -->|POST| E[doPost];
    C -->|PUT| F[doPut];
    C -->|DELETE| G[doDelete];
    C -->|PATCH| H[doPatch];
    D --> I[resolveRequest];
    E --> I[resolveRequest];
    F --> I[resolveRequest];
    G --> I[resolveRequest];
    H --> I[resolveRequest];
    I --> J[getRoute];
    J -->|Ruta Encontrada| K[controlAccess];
    J -->|Ruta No Encontrada| L[setUnkownResource];
    K --> M{Acceso Autorizado};
    M -->|Sí| N[executeSpecificREST];
    M -->|No| O[setUnauthorizedRequest];
    N --> P[Fin];
    O --> P[Fin];
    L --> P[Fin];
```
