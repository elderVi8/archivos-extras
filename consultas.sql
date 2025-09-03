
select p.proyecto_id , p.nombre as proyecto ,  
(coalesce(sum(o.total_asignado), 0) / nullif(sum(d.total_donaciones), 0)::float)*100 as porcentaje_ejecucion 
from proyecto p 
join proyecto_rubro pr 
on p.proyecto_id = pr.proyecto_id
left join (
    select proyecto_rubro_id, sum(monto) as total_donaciones
    from donacion
    where status = 1
    group by proyecto_rubro_id
) d on pr.proyecto_rubro_id = d.proyecto_rubro_id
left join (
    select proyecto_rubro_id, sum(monto_asignado) as total_asignado
    from orden_compra_rubro
    where status = 1
    group by proyecto_rubro_id
) o on pr.proyecto_rubro_id = o.proyecto_rubro_id
where p.status=1
group by p.proyecto_id, p.nombre
order by p.proyecto_id






select 
  p.proyecto_id,
  p.nombre as proyecto,
  r.nombre as rubro,
  coalesce(d.total_donaciones, 0) - coalesce(o.total_asignado, 0) as fondos
from proyecto p
join proyecto_rubro pr 
  on p.proyecto_id = pr.proyecto_id
join rubro r 
  on pr.rubro_id = r.rubro_id
left join (
    select proyecto_rubro_id, sum(monto) as total_donaciones
    from donacion
    where status = 1
    group by proyecto_rubro_id
) d on pr.proyecto_rubro_id = d.proyecto_rubro_id
left join (
    select proyecto_rubro_id, sum(monto_asignado) as total_asignado
    from orden_compra_rubro
    where status = 1
    group by proyecto_rubro_id
) o on pr.proyecto_rubro_id = o.proyecto_rubro_id
where p.status = 1
order by p.proyecto_id, r.nombre;





