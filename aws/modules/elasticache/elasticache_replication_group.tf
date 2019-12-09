#---------------------------------------------------
# Create AWS elasticache replication group
#---------------------------------------------------
resource "aws_elasticache_replication_group" "elasticache_replication_group" {  
    # Redis Master with One Replica with 1 shard
    count                           = var.num_cache_nodes >1 && var.number_cluster_replicas ==1 && var.create_single_cluster !="true" ? 1 : 0    

    replication_group_id            = var.replication_group_id != "" ? var.replication_group_id : "${lower(var.name)}-${lower(var.engine)}-${lower(var.environment)}"
    replication_group_description   = var.replication_group_description != "" ? var.replication_group_description : "The ${var.engine} master with 1 replica shard which managed by ${var.orchestration}"
    node_type                       = var.node_type
    number_cache_clusters           = var.num_cache_nodes
    port                            = var.default_ports[var.engine]
    engine                          = var.engine
    engine_version                  = var.engine_version
                                                                                            
    availability_zones              = var.availability_zones
    automatic_failover_enabled      = var.automatic_failover_enabled
    subnet_group_name               = var.subnet_group_name
    security_group_names            = [var.security_group_names_for_cluster]
    security_group_ids              = [var.security_group_ids]
    parameter_group_name            = var.parameter_group_name[var.engine] !="" ? var.parameter_group_name[var.engine] : element(aws_elasticache_parameter_group.elasticache_parameter_group.*.name, 0)
    at_rest_encryption_enabled      = var.at_rest_encryption_enabled
    transit_encryption_enabled      = var.transit_encryption_enabled
    #auth_token                      = var.auth_token
    
    auto_minor_version_upgrade      = var.auto_minor_version_upgrade
    snapshot_name                   = var.snapshot_name
    maintenance_window              = var.maintenance_window
    snapshot_window                 = var.snapshot_window
    snapshot_retention_limit        = var.snapshot_retention_limit
    apply_immediately               = var.apply_immediately
    
    notification_topic_arn          = var.notification_topic_arn

    tags = merge(
        {
            "Name"          = var.replication_group_id != "" ? var.replication_group_id : "${lower(var.name)}-${lower(var.engine)}-${lower(var.environment)}"
        },
        {
            "Environment"   = var.environment
        },
        {
            "Orchestration" = var.orchestration
        },
        {
            "Createdby"     = var.createdby
        },
        var.tags,
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on = [
        aws_elasticache_parameter_group.elasticache_parameter_group
    ]
}

resource "aws_elasticache_replication_group" "elasticache_replication_group_2" {
    # Redis Master with One Replica for each nodes
    count                           = var.num_cache_nodes >1 && var.number_cluster_replicas ==2 && var.create_single_cluster !="true" ? 1 : 0

    replication_group_id            = var.replication_group_id != "" ? var.replication_group_id : "${lower(var.name)}-${lower(var.engine)}-${lower(var.environment)}"
    replication_group_description   = var.replication_group_description != "" ? var.replication_group_description : "The ${var.engine} master with 2 replica shards which managed by ${var.orchestration}"
    node_type                       = var.node_type
    port                            = var.default_ports[var.engine]
    engine                          = var.engine
    engine_version                  = var.engine_version

    automatic_failover_enabled      = var.automatic_failover_enabled
    subnet_group_name               = var.subnet_group_name
    security_group_names            = [var.security_group_names_for_cluster]
    security_group_ids              = [var.security_group_ids]
    parameter_group_name            = var.parameter_group_name[var.engine] !="" ? var.parameter_group_name[var.engine] : element(aws_elasticache_parameter_group.elasticache_parameter_group.*.name, 0)
    at_rest_encryption_enabled      = var.at_rest_encryption_enabled
    transit_encryption_enabled      = var.transit_encryption_enabled
    #auth_token                      = var.auth_token

    auto_minor_version_upgrade      = var.auto_minor_version_upgrade
    snapshot_name                   = var.snapshot_name
    maintenance_window              = var.maintenance_window
    snapshot_window                 = var.snapshot_window
    snapshot_retention_limit        = var.snapshot_retention_limit
    apply_immediately               = var.apply_immediately

    notification_topic_arn          = var.notification_topic_arn

    dynamic "cluster_mode" {
        for_each = var.cluster_mode
        content {
            replicas_per_node_group     = lookup(cluster_mode.value, "replicas_per_node_group", null)
            num_node_groups             = lookup(cluster_mode.value, "num_node_groups", null)
        }
    }

    tags = merge(
        {
            "Name"          = var.replication_group_id != "" ? var.replication_group_id : "${lower(var.name)}-${lower(var.engine)}-${lower(var.environment)}"
        },
        {
            "Environment"   = var.environment
        },
        {
            "Orchestration" = var.orchestration
        },
        {
            "Createdby"     = var.createdby
        },
        var.tags,
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on = [
        aws_elasticache_parameter_group.elasticache_parameter_group
    ]
}
