from rdklib import Evaluator, Evaluation, ConfigRule, ComplianceType
import datetime
import logging
import json
log = logging.getLogger("a9n")
log.setLevel(logging.INFO)

class a9n(ConfigRule):
    def evaluate_change(self, event, client_factory, configuration_item, valid_rule_parameters):
        print("--- evaluate change ---")
        resource_type = configuration_item.get("resourceType")
        resource_id = configuration_item.get("resourceId")
        log.info("Evaluating change [%s] [%s]", resource_type, resource_id)
        log.debug("valid client parameters")
        log.debug(str(valid_rule_parameters))
        log.debug("event")
        log.debug(str(event))
        evaluation = Evaluation(ComplianceType.COMPLIANT, resourceId=resource_id, resourceType=resource_type, annotation="a9n")
        evaluations = [evaluation]
        return evaluations

    def evaluate_periodic(self, event, client_factory, valid_rule_parameters):
        print("--- evaluate periodic ---")
        print(json.dumps(event, indent=4, sort_keys=True))                                                                                                                   
        log.info("Evaluating periodic rule",)
        log.debug("valid client parameters")
        log.debug(str(valid_rule_parameters))
        log.debug("event")
        log.debug(str(event))
        # evaluation = Evaluation(ComplianceType.COMPLIANT, resourceId=resource_id, resourceType=resource_type, annotation="a9n")
        # evaluations = [evaluation]
        return []

    def evaluate_parameters(self, rule_parameters):
        print("--- evaluate parameters ---")
        print(json.dumps(rule_parameters, indent=4, sort_keys=True))
        valid_rule_parameters = rule_parameters
        return valid_rule_parameters


################################
# DO NOT MODIFY ANYTHING BELOW #
################################
def lambda_handler(event, context):
    print("--- event ---")
    print(json.dumps(event, indent=4, sort_keys=True))
    my_rule = a9n()
    evaluator = Evaluator(my_rule, expected_resource_types=["ALL"]) 
    # TODO
    return evaluator.handle(event, context)
