package dev.punchcafe.ai.bayesian;

import java.util.List;

public class NodeTable {
    private int tableSize;
    private List<NodeTableRow> rows;
}

class NodeState {

}

class NodeTableRow {
    private List<Object> conditionSet;
    private float probability;
}

class ConditionBuilder {
    ConditionBuilder given(NodeKey key, int state);

    /*

    enum MyNodeState {
      HAPPY, SAD
      // consider a pre-processor state to generate the required constant names??
    }

    .for(key3)
    .given(key1, 1)
    .given(key2, 2)
    .probabilityOfState(1, 0.5)
    .probabilityOfState(2, 0.2)

     */
}