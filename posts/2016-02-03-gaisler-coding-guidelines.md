-----
title: Gaisler Coding Guidelines
-----

The [Gaisler coding
guidelines](http://www.gaisler.com/doc/vhdl2proc.pdf) starts with a
description of a hideously coded latch with some data processing as an
example as why not to code in a data-flow manner. I strongly agree, as
the example has further bad naming, it splits signals that appear to
belong together et c. Furthermore the statements could be written as
one-liners without any process construct around them.

The goals of Gaisler Guidelines have been stated as follows

-   Provide uniform algorithm encoding
-   Increase abstraction level
-   Improve readability
-   Clearly identify sequential logic
-   Simplify debugging
-   Improve simulation speed
-   Provide one model for both synthesis and simulation.

In the following sections I will address each point where I disagree
with the design-guideline’s authors.

Provide uniform algorithm encoding
==================================

Will this is essentially holds, it basically forces the designer to
encode the algorithm in one process; the second is only to register
data. While this will create uniformity it also forces the algorithm in
a given form instead of using the best form the language can offer.

In order to save routing resources for FPGA designs it is *strongly*
recommended to avoid clearing/resetting signals that do not require it,
e.g., data signals with a valid signal. At least for the Xilinx
toolchain this can be achieved by resetting the signals to a don’t-care
value ‘-‘. This solution clearly is not expected to work with other
vendors.

It might furthermore be prohibitive of simple refactoring if the
combinatorial process grows excessively large. Extracting signals from a
large combinatorial process into a new entity/block can have dangerous
side-effects. If functionality that doesn’t necessarily belong to the
same entity, e.g., due to refactoring, still ended up together, it can
far more easily be split up if it’s been written in separate processes.

Increase abstraction level
==========================

Only for code written in forms as given in the example. Any
self-respecting designer doesn’t do this to him- or herself or the
verification/QA engineers. Always use the highest level of abstraction
suitable and supported by the toolchain, I .e, the future might finally
bring high-level synthesis.

Improve readability
===================

If we come to think of processes as functions in regular programming
languages, then they should do one thing and one thing only \[1\]. This
is a very reasonable approach as it otherwise groups functionality that
doesn’t need to be together.

By design, output assignments are part of the combinatorial process.
This does not help readability at all and should be avoided. Put output
assignments at the top for all outputs. As such, it is clearly visible
of what type of FSM this particular entity is made off. Mealy-type are
to be avoided if possible.

Nesting output records one or two levels deep might make sense when
properly named. If, as written in those guidelines, records are nested
as deep as the design testing becomes difficult. Updates to the record
are not automatically adjusted for in any test benches and no compiler
will complain about missing initialization.

Creating records should only be done if signals travel the hierarchy
unchanged for more than one, maybe two levels. Even then, unnecessary
nesting of signals that do not belong together should be avoided.

Be wary of the God-Entity equivalent to the God-Class in \[1\].

Clearly identify sequential logic
=================================

Yes, but at what cost? If output assignments are also tossed in for good
measure we cannot see any more of what type the FSM is built, i.e.,
Mealy or Moore. Separately assigning the output ports reduces to chance
of unwanted combinatorial paths. Always aim for a Medvedev FSM.

Simplify debugging
==================

I would not agree. At least older Modelsim tools have a hard time
tracking sources for drive conflicts as it always displays the entire
record. They also have troubles identifying FSM encoded with the
proposed method. This is not helpful for verification.

Improve simulation speed
========================

Have all signals in one process will actually diminish simulation
performance as an event in a signal in the sensitivity list will compute
the entire record anew. Smaller records/processes with smaller
sensitivity lists are expected to create lesser events and as such speed
up simulation.

It is speculated that the entire records will be saved by Modelsim even
if only a record’s subset is of particular interest.

Provide one model for both synthesis and simulation
===================================================

It is expected that the designer tests its units for synthesis errors as
a part of unit-verification. Golden-model or stimuli generation is a
different story and has been covered in other places by experienced
verification gurus.

Conclusion
==========

From my perspective, there are two things to be taken from this coding
guidelines

-   Group signals that truly belong together in a record and handle them
    in two processes. If possible, create a Medvedev FSM and connect the
    record directly to the output signals.
-   Create output records if they make sense, but do not nest if signals
    don’t clearly belong together. Be wary of nesting deeper than one
    sub-record. The record can then be routed to other entities and
    still benefit from changing the record without changing port
    definition in a large number of entities.

As final word: certainly more time is spent verifying designs than
actually writing the code. Hence any efficiency gained by writing
compact code can be quickly lost in the verification phase, i.e., trying
to curb VHDL’s inherent verbosity can quickly backfire.

\[1\] [R. Martin, Clean
Code](https://cleancoders.com/landing)([amazon](http://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882))
