# Software Requirement Engineering - Defense Questions
## FinTrack Project

---

## **Section 1: Requirement Elicitation & Analysis**

### Q1. Stakeholder Identification (Tricky)
**Question:** You've implemented features like transaction tracking, analytics, and wallet management. How did you identify and prioritize stakeholders for FinTrack? If a new stakeholder (e.g., a financial advisor who wants to access user data for consultation) emerges after development, how would you handle their requirements without violating existing functional and non-functional requirements?

**Expected Answer Points:**
- Primary stakeholders: End users (individuals tracking finances)
- Secondary stakeholders: Developers, testers, potential financial institutions
- Change management process
- Impact analysis on existing requirements (especially security/privacy)
- Requirement traceability matrix updates

---

### Q2. Requirement Elicitation Techniques
**Question:** Which elicitation techniques did you use for FinTrack? Why didn't you use prototyping or JAD sessions? Defend your choice with specific examples from your project.

**Expected Answer Points:**
- Techniques used (interviews, questionnaires, document analysis, observation)
- Justification for not using certain techniques
- Cost-benefit analysis of chosen techniques
- Examples: How did you discover the need for categories like "Food, Travel, Shopping, Health"?

---

### Q3. Ambiguity in Requirements (Very Tricky)
**Question:** Looking at your SRS document, identify at least THREE potentially ambiguous requirements in FinTrack. For example, what does "user-friendly interface" mean quantitatively? How would you measure it?

**Expected Answer Points:**
- Identification of vague terms (user-friendly, secure, fast, efficient)
- Conversion to measurable requirements (e.g., "90% of users should complete a transaction in under 30 seconds")
- Use of acceptance criteria
- Testability of requirements

---

## **Section 2: Functional vs Non-Functional Requirements**

### Q4. Classification Challenge
**Question:** Classify the following requirement: *"The system shall store user transaction data locally using SharedPreferences."* Is this functional or non-functional? Justify your answer. What if I argue it's a design decision rather than a requirement?

**Expected Answer Points:**
- Could be argued as both (implementation constraint - NFR, or data persistence - FR)
- Distinction between requirements and design
- Should be rephrased as: "System shall persist user data between sessions" (FR)
- Storage mechanism is design decision
- Understanding of requirement abstraction levels

---

### Q5. Missing Non-Functional Requirements
**Question:** Your app handles financial data. I don't see explicit requirements for:
- Data encryption at rest
- Session timeout after inactivity
- Audit logging
- Backup and recovery

Are these missing from your SRS? If yes, why? If no, where are they documented?

**Expected Answer Points:**
- Security requirements analysis
- Compliance requirements (GDPR, financial regulations)
- Risk assessment
- Prioritization of NFRs
- Trade-offs made during development

---

### Q6. Performance Requirements (Quantitative)
**Question:** You have a pie chart showing income/expense distribution. What is the maximum number of transactions your app can handle before performance degrades? Did you specify this in your SRS? How did you determine this threshold?

**Expected Answer Points:**
- Performance testing and benchmarking
- Scalability requirements
- Response time requirements
- Memory constraints on mobile devices
- Load testing results

---

## **Section 3: Requirement Specification & Documentation**

### Q7. SRS Quality Attributes
**Question:** An SRS should be: Complete, Consistent, Unambiguous, Verifiable, Modifiable, Traceable, and Ranked. Pick any TWO of these attributes and prove with examples from your FinTrack SRS that you've achieved them. Then, identify ONE attribute where your SRS falls short.

**Expected Answer Points:**
- Concrete examples from SRS document
- Self-awareness of documentation gaps
- Understanding of IEEE 830 standard
- Improvement suggestions

---

### Q8. Requirement Traceability (Very Tricky)
**Question:** Trace the requirement "User shall be able to add a transaction" from:
1. Business need → 2. User requirement → 3. System requirement → 4. Design → 5. Code → 6. Test case

Can you provide this complete trace? What happens if this requirement changes (e.g., now transactions need approval workflow)?

**Expected Answer Points:**
- Complete traceability matrix
- Forward and backward traceability
- Impact analysis of requirement changes
- Change propagation through SDLC phases
- Specific code references (dashboard_screen.dart, _addTransaction method)

---

### Q9. Use Case vs User Story
**Question:** Write a complete use case for "Delete Transaction" with:
- Preconditions
- Main flow
- Alternative flows
- Postconditions
- Exception handling

Now convert this into a user story with acceptance criteria. Which format is better for FinTrack and why?

**Expected Answer Points:**
- Proper use case format
- User story format (As a... I want... So that...)
- Comparison of both approaches
- Agile vs traditional methodologies
- Suitability for mobile app development

---

## **Section 4: Requirement Validation & Verification**

### Q10. Validation Techniques
**Question:** How did you validate that your requirements actually meet user needs? Did you conduct user acceptance testing? If a user says "I expected to see monthly spending trends, not just a pie chart," does this indicate a requirement validation failure or a requirement elicitation failure?

**Expected Answer Points:**
- Validation vs verification distinction
- Validation techniques used (reviews, prototyping, testing)
- Root cause analysis of the scenario
- Requirement baseline and change control
- User feedback incorporation

---

### Q11. Inconsistency Detection (Tricky)
**Question:** Suppose your SRS states:
- FR1: "User must log in to access the dashboard"
- FR2: "Guest users can view sample transactions"
- FR3: "All features require authentication"

Identify the inconsistency. How would you detect such conflicts in a large SRS document?

**Expected Answer Points:**
- Conflict between FR2 and FR3
- Automated consistency checking tools
- Formal methods (if applicable)
- Requirement review processes
- Conflict resolution strategies

---

### Q12. Testability of Requirements
**Question:** Consider this requirement: "The app should provide a good user experience." 
- Why is this untestable?
- How would you rewrite it to be testable?
- Provide 3 testable requirements derived from this vague statement.

**Expected Answer Points:**
- SMART criteria (Specific, Measurable, Achievable, Relevant, Time-bound)
- Quantifiable metrics (task completion time, error rate, user satisfaction score)
- Example testable requirements:
  - "90% of users shall complete adding a transaction in under 45 seconds"
  - "System shall respond to user input within 200ms"
  - "App shall achieve a SUS score above 70"

---

## **Section 5: Requirement Management & Change**

### Q13. Requirement Prioritization (Very Tricky)
**Question:** You have limited time before the defense. Prioritize these new requirements using MoSCoW method and justify:
1. Multi-currency support
2. Biometric authentication
3. Export transactions to PDF
4. Dark mode
5. Recurring transaction templates
6. Budget alerts when spending exceeds limit

Now, a stakeholder insists ALL are "Must Have." How do you handle this?

**Expected Answer Points:**
- MoSCoW categorization with justification
- Stakeholder negotiation techniques
- Cost-benefit analysis
- Risk assessment
- Resource constraints
- Scope creep management

---

### Q14. Requirement Change Management
**Question:** Midway through development, a requirement changes: "Instead of local storage (SharedPreferences), use Firebase for cloud sync." 
- What is the impact?
- How many requirements are affected?
- What is your change control process?
- Would you accept or reject this change at this stage?

**Expected Answer Points:**
- Change impact analysis
- Affected components (data layer, architecture)
- Change Control Board (CCB) process
- Cost and schedule impact
- Risk assessment
- Configuration management
- Baseline management

---

### Q15. Requirement Volatility
**Question:** Financial regulations change frequently. How did you design your requirements to accommodate future regulatory changes? Give specific examples of requirements that are "change-resilient."

**Expected Answer Points:**
- Anticipatory requirements
- Flexible architecture
- Separation of concerns
- Configurable business rules
- Extensibility considerations
- Version control of requirements

---

## **Section 6: Special Requirements & Constraints**

### Q16. Security Requirements (Critical)
**Question:** Your app stores financial data locally. 
- What security requirements did you specify?
- How do you prevent unauthorized access if the phone is stolen?
- Did you consider SQL injection (if using SQLite)?
- What about data encryption?

Defend your security posture.

**Expected Answer Points:**
- Authentication mechanisms
- Data encryption (at rest and in transit)
- Secure storage practices
- Input validation
- Session management
- Security testing requirements
- Threat modeling

---

### Q17. Platform Constraints
**Question:** FinTrack is built with Flutter. How did platform constraints (iOS vs Android) affect your requirements? Give examples of platform-specific requirements or constraints.

**Expected Answer Points:**
- Cross-platform considerations
- Platform-specific UI/UX guidelines (Material Design vs Cupertino)
- Permission models (iOS vs Android)
- Storage mechanisms
- Notification handling
- Biometric authentication differences

---

### Q18. Usability Requirements (Tricky)
**Question:** You have users ranging from tech-savvy millennials to elderly people unfamiliar with apps. How did you specify usability requirements to accommodate this diverse user base? What accessibility features did you include?

**Expected Answer Points:**
- User persona development
- Accessibility requirements (WCAG compliance)
- Font size, color contrast
- Screen reader support
- Internationalization (i18n)
- Localization (l10n)
- User testing with diverse groups

---

## **Section 7: Requirements Engineering Process**

### Q19. RE Process Model
**Question:** Which RE process model did you follow: Waterfall, Iterative, Agile, or Spiral? Justify your choice. If you followed Agile, how did you handle upfront requirements documentation (since Agile favors working software over comprehensive documentation)?

**Expected Answer Points:**
- Process model selection rationale
- Agile vs plan-driven balance
- Just-enough documentation
- Iterative refinement of requirements
- Sprint planning and backlog management
- Definition of Done (DoD)

---

### Q20. Requirements Baseline
**Question:** At what point did you baseline your requirements? What was included in version 1.0 of your SRS? How do you manage requirements after baselining?

**Expected Answer Points:**
- Baseline definition and timing
- Version control of SRS
- Change control after baseline
- Configuration management
- Traceability maintenance
- Release planning

---

## **Section 8: Domain-Specific Questions (Finance Domain)**

### Q21. Domain Knowledge
**Question:** FinTrack deals with financial transactions. Did you consult domain experts (accountants, financial advisors)? What domain-specific requirements did you identify that a non-expert might miss?

**Expected Answer Points:**
- Domain analysis
- Domain expert involvement
- Financial terminology (debit/credit, reconciliation)
- Tax reporting requirements
- Audit trails
- Compliance requirements

---

### Q22. Data Integrity Requirements
**Question:** In financial systems, data integrity is critical. What requirements did you specify to ensure:
- Transactions cannot be modified after creation?
- No transaction is lost?
- Calculations (total balance) are always accurate?

**Expected Answer Points:**
- ACID properties (if using database)
- Immutability of transactions
- Data validation rules
- Calculation verification
- Backup and recovery
- Audit logging

---

## **Section 9: Advanced/Conceptual Questions**

### Q23. Goal-Oriented Requirements Engineering
**Question:** Using KAOS (Knowledge Acquisition in Automated Specification) or i* framework, model the high-level goals of FinTrack and decompose them into sub-goals and requirements. Show at least 3 levels of decomposition.

**Expected Answer Points:**
- Top goal: "Achieve effective personal finance management"
- Sub-goals: Track expenses, Analyze spending, Budget planning
- Operationalization to requirements
- AND/OR decomposition
- Obstacle analysis

---

### Q24. Formal Specification (Very Tricky)
**Question:** Write a formal specification (using Z notation or OCL) for the constraint: "Total Balance = Total Income - Total Expense" and "Total Balance must always be accurate."

**Expected Answer Points:**
- Formal methods knowledge
- Invariant specification
- Pre/post conditions
- State machine representation
- Benefits and limitations of formal methods

---

### Q25. Requirements Reuse
**Question:** If you were to build FinTrack 2.0 or a similar app for business expense tracking, which requirements could you reuse? How would you organize requirements for reuse?

**Expected Answer Points:**
- Requirement patterns
- Product line engineering
- Commonality and variability analysis
- Requirement repositories
- Domain engineering
- Feature models

---

## **Section 10: Critical Thinking & Reflection**

### Q26. Requirements Engineering Challenges
**Question:** What was the MOST DIFFICULT aspect of requirements engineering for FinTrack? How did you overcome it? What would you do differently if you started over?

**Expected Answer Points:**
- Self-reflection
- Lessons learned
- Challenges faced (scope creep, changing requirements, stakeholder conflicts)
- Solutions applied
- Process improvements

---

### Q27. Ethical Requirements
**Question:** Users trust FinTrack with sensitive financial data. What ethical requirements did you consider? For example:
- User consent for data collection
- Transparency about data usage
- Right to delete data
- Privacy by design

**Expected Answer Points:**
- Ethical considerations in RE
- Privacy requirements
- GDPR compliance
- Informed consent
- Data minimization
- Transparency requirements

---

### Q28. AI/ML Integration (Future-Looking)
**Question:** If you were to add AI-powered spending predictions to FinTrack, how would you specify requirements for:
- Prediction accuracy?
- Explainability of predictions?
- Bias prevention?
- User control over AI features?

**Expected Answer Points:**
- Requirements for AI/ML systems
- Accuracy metrics
- Explainable AI (XAI) requirements
- Fairness and bias
- Human-in-the-loop
- Fallback mechanisms

---

### Q29. Sustainability Requirements (Emerging Topic)
**Question:** Did you consider sustainability requirements? For example:
- Energy efficiency (battery consumption)
- Data storage optimization
- Carbon footprint of cloud services (if any)

How would you specify such requirements?

**Expected Answer Points:**
- Green software engineering
- Energy efficiency metrics
- Resource optimization
- Sustainable design principles
- Environmental impact assessment

---

### Q30. The Ultimate Question (Meta-Level)
**Question:** "Requirements engineering is often considered the most critical phase of software development, yet it's frequently done poorly." Do you agree? Based on your FinTrack experience, what percentage of project success depends on good requirements engineering? Defend your answer.

**Expected Answer Points:**
- Critical analysis of RE importance
- Statistics/studies on project failures due to poor requirements
- Personal experience reflection
- Balance between RE and other phases
- Context-dependent answer
- Practical wisdom

---

## **Bonus: Scenario-Based Questions**

### Q31. Conflict Resolution Scenario
**Scenario:** Your product owner wants "instant transaction sync across devices" but your technical lead says "local-only storage is a core architectural decision." How do you resolve this requirements conflict?

**Expected Answer Points:**
- Stakeholder negotiation
- Technical feasibility analysis
- Alternative solutions (hybrid approach)
- Trade-off analysis
- Decision documentation

---

### Q32. Scope Creep Scenario
**Scenario:** Two days before your defense, your professor suggests adding "investment portfolio tracking" to FinTrack. How do you respond from a requirements management perspective?

**Expected Answer Points:**
- Scope management
- Change control process
- Impact analysis
- Polite but firm pushback
- Future version planning
- Documentation of rejected requirements

---

## **Preparation Tips:**

1. **Know Your SRS Inside-Out:** Be able to reference specific sections, page numbers, and requirement IDs.

2. **Prepare Traceability Matrix:** Have a clear mapping from requirements to design to code to tests.

3. **Understand Trade-offs:** Be ready to defend why you chose certain requirements over others.

4. **Admit Gaps:** If there are missing requirements, acknowledge them and explain how you'd address them.

5. **Use Proper Terminology:** Functional vs Non-functional, Validation vs Verification, Elicitation vs Analysis, etc.

6. **Quantify When Possible:** Instead of "fast," say "responds within 200ms."

7. **Link to Code:** Be able to show how gfgffffffffffffffgf are implemented in your Flutter code.

8. **Prepare Diagrams:** Use cases, activity diagrams, state machines, requirement dependency graphs.

9. **Practice Defending Decisions:** Every requirement choice should have a rationale.

10. **Stay Calm:** If you don't know an answer, acknowledge it and explain how you'd find the answer.

---

## **Good Luck with Your Defense! 🚀**

**Remember:** The goal is not to have perfect requirements, but to demonstrate your understanding of the requirements engineering process, your ability to think critically, and your capacity to make informed decisions under constraints.
