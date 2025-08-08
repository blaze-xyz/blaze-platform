# Visuals

## Purpose
Include all relevant design mockups, wireframes, user flows, and diagrams. Visual documentation helps ensure alignment between product, design, and engineering teams.

### Key Components:
- User interface mockups
- User flow diagrams
- System architecture diagrams
- State diagrams
- Interaction specifications

### Template:
```
## Visuals

### User Flows
![User Flow Diagram](path/to/user-flow.png)
*Description: [Explain the flow and key decision points]*

### UI Mockups

#### [Screen/Component Name]
![Mockup](path/to/mockup.png)
- **Purpose**: [What this screen accomplishes]
- **Key Elements**: [List important UI elements]
- **Interactions**: [Describe user interactions]

### State Diagrams
![State Diagram](path/to/state-diagram.png)
*Description: [Explain different states and transitions]*

### Technical Diagrams
![Architecture Diagram](path/to/architecture.png)
*Description: [Explain system components and data flow]*

### Design Specifications
- **Colors**: [Brand colors and usage]
- **Typography**: [Font specifications]
- **Spacing**: [Layout guidelines]
- **Components**: [Reusable component library]
```

### Best Practices:
1. **Export all designs as PNG**: Use high-resolution exports for clarity
2. **Include annotations**: Add notes directly on mockups for complex interactions
3. **Show all states**: Include loading, error, empty, and success states
4. **Mobile and desktop**: Provide responsive design variations
5. **Accessibility**: Include specs for screen readers and keyboard navigation

### Recommended Tools:
- **Figma**: For collaborative design and easy PNG exports
- **Miro/FigJam**: For user flow diagrams
- **draw.io**: For technical architecture diagrams
- **Loom**: For interaction videos when static images aren't sufficient

### File Organization:
```
visuals/
├── user-flows/
│   ├── main-flow.png
│   └── error-flow.png
├── mockups/
│   ├── desktop/
│   └── mobile/
├── diagrams/
│   ├── architecture.png
│   └── state-machine.png
└── specs/
    ├── design-system.png
    └── component-library.png
```