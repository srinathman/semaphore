alter table `task` change `build_task_id` `build_task_id_old` int;

alter table `task` add column `build_task_id` int;

update `task` set `build_task_id` = `build_task_id_old` where `build_task_id_old` is not null;

update `task` set `build_task_id_old` = null where `build_task_id_old` is not null;

alter table `task`
    add constraint `task_build_task_id_fk_y38rt`
        foreign key (`build_task_id`) references `task` (`id`)
            on delete set null;


create table `project__template_backup_385025846` (
    id int,
    removed boolean default false
);

insert into `project__template_backup_385025846` select `id`, `removed` from `project__template`;

update `project__template`
set build_template_id = null
where (select t.`removed` from `project__template_backup_385025846` t where t.`id` = `build_template_id`) = true;

drop table `project__template_backup_385025846`;

delete from `project__template` where `removed` = true;

alter table `project__template` drop column `removed`;
